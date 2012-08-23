# WARNING!!! PARTIALLY COMPLETE AND BARELY TESTED
Please check back. I hope to have a usable version soon...

# Dpass

Application specific passwords derived from your secret master password using [PBKDF2](http://en.wikipedia.org/wiki/PBKDF2) implemented by OpenSSL.

## Installation

Install the gem:

    $ gem install dpass --pre

You need your dpass salt file in your home directory (~/.dpass). The SAME salt file must be installed in the home directory on each machine you want to run dpass (different salt = different passwords). So copy any perviously created salt file to your home directory.

    $ cp path_to_existing/.dpass ~/.dpass

If this is the first time you are using dpass create a new personal salt file:

    $ dpass salt new **NOT YET - MUST BE MANUALLY CREATED***

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

## Background

The theft of passwords from internet sites seems to be an [increasingly](http://press.linkedin.com/node/1212) [common](http://ycorpblog.com/2012/07/13/yahoo-0713201/) [occurance](http://us.blizzard.com/en-us/securityupdate.html). Combined with the common practice of using either the same or related passwords across this is a serious risk to millions of people.
Clearly you need a unique and strong password for every site you visit. I recently took Dan Boneh's excellent Cryptography class on [Coursera](https://www.coursera.org/course/crypto) and learned that this is a well known problem, password based key derivation, with standard solutions.
Inspired by a [broken idea](http://news.ycombinator.com/item?id=4373909) on Hacker News and ignoring warnings to never even think about building your own crypto I made dpass.

## Other Password Managers

[LastPass](https://lastpass.com/), [KeePass](http://keepass.info/), [PwdHash](https://www.pwdhash.com/)

## References

Dan Boneh - Key Derivation Lecture - http://www.youtube.com/watch?v=ZorKf6IaP0Q
PKCS #5 RFC - http://tools.ietf.org/html/rfc2898
PBKDF2 Test Vectors RFC - http://tools.ietf.org/html/rfc6070
OpenSSL Gem PKCS5 - http://www.ruby-doc.org/stdlib-2.0/libdoc/openssl/rdoc/OpenSSL/PKCS5.html
