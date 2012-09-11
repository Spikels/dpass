# WARNING!!! DO NOT USE! NEITHER COMPLETE OR WELL-TESTED!
Please check back soon a usable version...

# Dpass [![Build Status](https://secure.travis-ci.org/Spikels/dpass.png)](http://travis-ci.org/Spikels/dpass)

Application specific passwords derived from your secret master password using [PBKDF2](http://en.wikipedia.org/wiki/PBKDF2) from OpenSSL already installed on your computer.

## Installation

Dpass currently requires Ruby 1.9.x but should soon work for all versions.

Install the gem:

    $ gem install dpass --pre

You need a personal dpass salt file in your home directory (~/.dpass). The SAME salt file must be installed in the home directory on each machine you want to run dpass or else you will get different derived passwords. So if you already have one you use, copy any perviously created salt file to your home directory.

If this is the first time you are using dpass, go ahead and create a new personal salt file:

    $ dpass -new_salt

## Usage

    $ dpass <application_1>[...<application_N>]

For example to generate a password for Gmail and Yahoo

    $ dpass gmail yahoo

You will be asked for your master password then a password will be generated for each application specified.

## Background

The theft of passwords from internet sites seems to be an [increasingly](http://press.linkedin.com/node/1212) [common](http://ycorpblog.com/2012/07/13/yahoo-0713201/) [occurance](http://us.blizzard.com/en-us/securityupdate.html). Combined with the common practice of using either the same or related passwords across this is a serious security risk.

Clearly you should have a independent and strong password for every site you visit. I recently took Dan Boneh's excellent Cryptography class on [Coursera](https://www.coursera.org/course/crypto) and learned that this well known problem, known as "password based key derivation", has standard solutions.

Inspired by a [broken idea](http://news.ycombinator.com/item?id=4373909) on Hacker News and ignoring warnings to never even think about building your own crypto I made dpass.

## Other Password Managers

[LastPass](https://lastpass.com/), [KeePass](http://keepass.info/), [PwdHash](https://www.pwdhash.com/)

## References

* Dan Boneh - Key Derivation Lecture - http://www.youtube.com/watch?v=ZorKf6IaP0Q
* PKCS #5 RFC - http://tools.ietf.org/html/rfc2898
* PBKDF2 Test Vectors RFC - http://tools.ietf.org/html/rfc6070
* OpenSSL Gem PKCS5 - http://www.ruby-doc.org/stdlib-2.0/libdoc/openssl/rdoc/OpenSSL/PKCS5.html

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
