# Dpass

Derive application specific passwords from secret master password using PBKDF2 in OpenSSL

## Installation

Install the gem:

    $ gem install dpass

dpass requires a salt file in your home directory (~/.dpass). The SAME salt file must be installed in the home directory (different salt = different passwords). Copy any perviously created salt file to your home directory.

    $ cp path_to_existing/.dpass

If this is the first time you are using dpass create a personal salt file:

    $ dpass salt new

## Usage

    $ dpass <application>

For example to generate a password for Gmail:

    $ dpass gmail

You will be asked for your master password then the password will be generated for the specified application.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## References

Dan Boneh - Key Derivation Lecture - http://www.youtube.com/watch?v=ZorKf6IaP0Q
PKCS #5 RFC - http://tools.ietf.org/html/rfc2898
PBKDF2 Test Vectors RFC - http://tools.ietf.org/html/rfc6070
OpenSSL Gem PKCS5 - http://www.ruby-doc.org/stdlib-2.0/libdoc/openssl/rdoc/OpenSSL/PKCS5.html
