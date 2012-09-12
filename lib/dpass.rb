require 'dpass/version'
require 'dpass/settings'
require 'openssl'
require 'securerandom'
require 'clipboard'

SALT = Dpass::SALT_PATH

module Dpass

  def self.derive
    verify_settings()
    salt = read_salt()
    master_pass = get_password_masked()
    ARGV.each do |app_name|
      pass_bytes = Dpass.derive_raw_hex(master_pass,
                           salt+app_name,
                           Dpass::HASH_ITER,
                           Dpass::PASS_LENGTH_BYTES)
      pass_syms = Dpass.rebase_bytes(pass_bytes, Dpass::SYMBOL_COUNT)
      pass = pass_syms.map {|c| Dpass::SYMBOLS[c]}.join
      pass = pass[0..(PASS_LENGTH_SYMBOLS-1)]
      puts "#{app_name}: #{pass}"
      Clipboard.copy pass
      delay_wipe_clipboard()
    end
    # Overwrite master password in memory with random bytes
    master_pass.replace SecureRandom.random_bytes(master_pass.length)
  end

  def self.rebase_bytes(hex_string, new_base)
    num = hex_string.to_i(16)
    result = []
    while num > 0
      result.unshift num % new_base
      num /= new_base
    end
    result.shift #Remove biased-downward first digit (not always needed)
    return result
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
    if password.length < WARN_MASTER_PASS_LENGTH
        puts "WARNING: Your master password should be at least #{WARN_MASTER_PASS_LENGTH} characters long."
    end
    return password
  end

  def self.derive_raw_hex(pass, salt, iter, keylen)
    OpenSSL::PKCS5.pbkdf2_hmac_sha1(pass,salt,iter,keylen).unpack('H*')[0]
  end

  def self.generate_salt
    SecureRandom.hex(Dpass::SALT_SIZE)
  end

  def self.read_salt
    Dpass.verify_salt
    File.open(SALT, 'rb') {|f| f.read.strip}
  end

  def self.new_salt
    if File.exists?(SALT)
      raise StandardError, "ERROR: dpass salt file (#{SALT}) already exists. A NEW SALT FILE WILL BREAK ALL EXISTING DERIVED PASSWORDS! If you really want this, you must manually delete or move the existing salt file."
    else
      new_value = Dpass.generate_salt
      File.open(SALT, 'wb', 0600) {|f| f.write new_value + "\n"}
      # Verify salt file
      Dpass.verify_salt(new_value)
      puts "Generated new random salt: #{new_value}"
      puts "Saved to #{SALT}, set permission (0600) and verfied"
    end
  end

  def self.verify_salt(expected_value = nil)
    if !File.exists?(SALT)
      raise StandardError, "ERROR: salt file (#{SALT}) does not exist. Use 'dpass salt' command to create a new one"
    end
    currrent_salt = File.open(SALT, 'rb')
    if expected_value && expected_value != currrent_salt
      raise StandardError, "ERROR: salt in file does not match new salt just create"
    end
    # WARNING: PERMISSION BITS ARE PROBABLY OS SPECIFIC...
    if (mode = File.stat(SALT).mode) != 33152  # 100600 in octal
      puts "WARNING: salt file (#{SALT}) permission not strict enough (#{sprintf("%o",mode)[2..-1]}). Use 'chmod 0600 ~/.dpass' limit access only to user."
    end         
    ### Check length
    ### Check character set
  end

  def self.verify_settings
    # TODO-Check: HASH_ITER, PASS_LENGTH, SYMBOL_COUNT, SYMBOLS.length
  end

  def self.delay_wipe_clipboard
    job1 = fork do
      sleep WIPE_CLIPBOARD_DELAY
      Clipboard.clear
    end
    Process.detach(job1)
  end
end
