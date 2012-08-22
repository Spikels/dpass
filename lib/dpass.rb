require 'dpass/version'
require 'openssl'

module Dpass
  def self.derive_raw_hex(pass, salt, iter, keylen)
    OpenSSL::PKCS5.pbkdf2_hmac_sha1(pass,salt,iter,keylen).unpack('H*')[0]
  end
end
