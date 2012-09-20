require 'dpass/version'
require 'dpass/settings'
require 'openssl'
require 'securerandom'
require 'clipboard'

# Note globals stored in ./lib/dpass/settings.rb
SYMBOLS = Dpass::SYMBOL_SETS[Dpass::SYMBOL_SET]
SYMBOL_COUNT = SYMBOLS.length
# Calc bytes needed rounding up with extra extra symbol cushion
PASS_LENGTH_BYTES = (Math::log(SYMBOL_COUNT**(Dpass::PASS_LENGTH_SYMBOLS+1))/Math::log(256) + 1).truncate

module Dpass

  def self.derive
    verify_settings()
    salt = read_salt()
    master_pass = get_password_masked()
    pass = ""
    ARGV.each do |app_name|
      pass_bytes = derive_raw_hex(master_pass, salt + app_name,
                           Dpass::HASH_ITER, PASS_LENGTH_BYTES)
      pass_syms = rebase_bytes(pass_bytes, SYMBOL_COUNT)
      pass = pass_syms.map {|c| SYMBOLS[c]}.join
      pass = pass[0..(Dpass::PASS_LENGTH_SYMBOLS-1)]
      puts "#{app_name}: #{pass}"
    end
    save_to_clipboard(ARGV[-1], pass)
    # Overwrite passwords in memory with random bytes
    pass.replace SecureRandom.random_bytes(pass.length)
    master_pass.replace SecureRandom.random_bytes(master_pass.length)
  end

  def self.rebase_bytes(hex_string, new_base)
    num = hex_string.to_i(16)
    result = []
    while num > 0
      result.unshift num % new_base
      num /= new_base
    end
    result.shift #Remove remove biased-downward first digit (not needed?)
    if (result.length > Dpass::PASS_LENGTH_SYMBOLS)
      return result
    else
      puts "INTERNAL ERROR: Rebased bytes NOT longer than symbols requested. Byte calculation must be wrong!"
      abort
    end
  end

  def self.get_password_masked(mask='*')
    buffering = $stdout.sync
    $stdout.sync = true
    stty_settings = %x[stty -g]
    begin
      %x[stty -echo]
      %x[stty -icanon]
      print 'Enter Master Password: '
      password = ""
      while ( char = $stdin.getc ) != "\n" # break after [Enter]
        putc mask
        password << char
      end
    ensure
      %x[stty #{stty_settings}]
      $stdout.sync = buffering
      puts
    end
    password.chomp
    if password.length < Dpass::WARN_MASTER_PASS_LENGTH
        puts "WARNING: Your master password should be at least #{Dpass::WARN_MASTER_PASS_LENGTH} characters long."
    end
    # Also need hard minimum master password length?
    return password
  end

  def self.derive_raw_hex(pass, salt, iter, keylen)
    OpenSSL::PKCS5.pbkdf2_hmac_sha1(pass,salt,iter,keylen).unpack('H*')[0]
  end

  def self.generate_salt
    SecureRandom.hex(Dpass::SALT_LENGTH_BYTES)
  end

  def self.read_salt
    verify_salt
    File.open(Dpass::SALT_PATH, 'rb') {|f| f.read.strip}
  end

  def self.new_salt
    if File.exists?(Dpass::SALT_PATH)
      puts "ERROR: A dpass salt file already exists (#{Dpass::SALT_PATH}). CHANGING THE SALT FILE WILL CHANGE ALL DERIVED PASSWORDS! If you really want this, manually delete or move the existing salt file."
    else
      new_value = generate_salt
      File.open(Dpass::SALT_PATH, 'wb', 0600) {|f| f.write new_value + "\n"}
      # Verify salt file
      verify_salt(new_value)
      puts "Generated new random salt: #{new_value}"
      puts "Saved to #{Dpass::SALT_PATH}, set permission (0600) and verfied"
    end
  end

  def self.info
    puts "Under construction..."
    verify_salt
    verify_settings
    verify_environment
  end

  def self.verify_salt(expected_value=nil)
    if !File.exists?(Dpass::SALT_PATH)
      puts "ERROR: salt file (#{Dpass::SALT_PATH}) does not exist. Use 'dpass --new-salt' command to create a new one"
      abort
    end
    currrent_salt = File.open(Dpass::SALT_PATH, 'rb') {|f| f.read.strip}
    if expected_value && expected_value != currrent_salt
      puts "ERROR: salt in file does not match new salt just create"
      abort
    end
    # WARNING: PERMISSION BITS ARE PROBABLY OS SPECIFIC...
    if (mode = File.stat(Dpass::SALT_PATH).mode) != 33152  # 100600 in octal
      puts "WARNING: salt file (#{Dpass::SALT_PATH}) permission not strict enough (#{sprintf("%o",mode)[2..-1]}). Use 'chmod 0600 ~/.dpass' limit access only to user."
    end
    if (currrent_salt.length != 2 * Dpass::SALT_LENGTH_BYTES)
      puts "WARNING: salt file length (#{currrent_salt.length}) not consistent with settings.rb (#{Dpass::SALT_LENGTH_BYTES})"
    end
    ### Check character set
    if (currrent_salt.gsub(/[0-9a-f]/,'').length != 0)
      puts "WARNING: salt file contains non-hexidecimal characters."
    end
  end

  def self.verify_settings
    # TODO-Check: HASH_ITER
    # TODO-Check: PASS_LENGTH
    # TODO-Check: SYMBOL_COUNT
    # TODO-Check: SYMBOLS.length
  end

  def self.verify_environment
    require 'mkmf'
    pkg_config('openssl')
    puts OpenSSL::OPENSSL_VERSION
    sha256_avail = have_func('PKCS5_PBKDF2_HMAC')
    sha1_avail = have_func('PKCS5_PBKDF2_HMAC_SHA1')
  end

  def self.save_to_clipboard(app_name, pass)
    Clipboard.copy pass
    # Clear clipboard after delay
    job1 = fork do
      sleep Dpass::WIPE_CLIPBOARD_DELAY_IN_SECONDS
      Clipboard.clear
    end
    Process.detach(job1)
    puts "#{app_name} password in clipboard for next #{Dpass::WIPE_CLIPBOARD_DELAY_IN_SECONDS} seconds"
  end
end
