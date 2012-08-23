require 'dpass/version'
require 'openssl'
require 'securerandom'

module Dpass
  def self.derive_raw_hex(pass, salt, iter, keylen)
    OpenSSL::PKCS5.pbkdf2_hmac_sha1(pass,salt,iter,keylen).unpack('H*')[0]
  end

  def self.generate_salt
    SecureRandom.hex(16)
  end
end
