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

    $ dpass <application> (ex. dpass gmail)

You will be asked for your master password then the password will be generated for the specified application.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
