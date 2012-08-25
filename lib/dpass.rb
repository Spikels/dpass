require 'dpass/version'
require 'dpass/settings'
require 'openssl'
require 'securerandom'

SALT = Dpass::SALT_PATH

module Dpass
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
    return password.chomp
  end

  def self.derive
    salt = read_salt()
    # TODO-Check: HASH_ITER, PASS_LENGTH, SYMBOL_COUNT, SYMBOLS.length
    #master_pass = get_password()
    master_pass = get_password_masked()
    # TODO-Check: master_pass (min length)
    ARGV.each do |arg|
      bytes = Dpass.derive_raw_hex(master_pass,
                           salt+arg,
                           Dpass::HASH_ITER,
                           Dpass::PASS_LENGTH)
      syms = Dpass.rebase_bytes(bytes, Dpass::SYMBOL_COUNT)
      pass = syms.map {|c| Dpass::SYMBOLS[c]}.join
      puts "#{arg}: #{pass}"
    end
    master_pass.replace SecureRandom.random_bytes(master_pass.length)
  end

  def self.derive_raw_hex(pass, salt, iter, keylen)
    OpenSSL::PKCS5.pbkdf2_hmac_sha1(pass,salt,iter,keylen).unpack('H*')[0]
  end

  def self.generate_salt
    SecureRandom.hex(Dpass::SALT_SIZE)
  end

  def self.read_salt
    if File.exists?(SALT)
      File.open(SALT, 'rb') {|f| f.read.strip}
    else
      raise StandardError, "ERROR: salt file (#{SALT}) does not exist. Use 'dpass salt' command to create a new one"
    end
  end

  def self.new_salt
    if File.exists?(SALT)
      raise StandardError, "ERROR: dpass salt file (#{SALT}) already exists. A NEW SALT FILE WILL BREAK ALL EXISTING DERIVED PASSWORDS! If you really want this, you must manually delete or move the existing salt file."
    else
      new_value = Dpass.generate_salt
      puts "Generated new random salt: #{new_value}"
      File.open(SALT, 'wb') {|f| f.write new_value + "\n"}
      File.chmod(0600, SALT)
      # Verify salt file
      if new_value != Dpass.read_salt
        puts "ERROR: salt in file does not match new salt just create"
      else
        puts "Saved to #{SALT}, set permission and verfied"
      end
    end
  end
end
