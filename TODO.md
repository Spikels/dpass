# TODO


* General
  * Make work under Ruby 1.8.x (must be using 1.9 syntax)


* Tests
  * DONE-Add Travis CI
  * Figure out how to mock the 2 file system tests
  * Add tests to new code & test frist going forward!
  * Test under Ruby 1.8.x (Travis)
  * ??? - Test on Windows


* Command-line
  * DONE-Allow multiple applications (i.e. dpass gmail yahoo)
  * Add --init command (test install, new-salt & print basic instructions)
  * Add --test command (check ruby version, openssl, ...)


* Create salt file (~/.dpass)
  * DONE-Check if file already exists. If so abort with message to delete manually if you really want a NEW salt file.
  * DONE-Generate 128-bit random salt (32 hex chars)
  * DONE-Save to file ~/.dpass
  * DONE-Set permission to 600
  * Handle File.open errors
  * Handle File.chown errors
  * ???-Append new salts so old salts are not lost (w/ create date?)


* Validate salt file
  * DONE - Warn if salt file permission is not 0600 (Is this OS specific?)
  * Check salt is valid length
  * Check salt is hex character set only
  * ???-Check that salt seems random (how?)

* Read salt file (~/.dpass)
  * DONE-Check that file exists. If not abort with message to copy existing salt or create new salt if you REALLY want to.
  * DONE-Read salt file
  * DONE-Warn if salt file permission is not 0600 (Is this OS specific?)

* Master password
  * DONE-Remove highline dependency
  * DONE-Clear from memory ASAP string.replace
  * Allow delete/backspace when entering master password

* Settings
  * Remove calculated settings from setting.rb (put in dpass.rb)
  * Check HASH_ITER is reasonable before use
  * Check PASS_LENGTH is reasonable before use
  * Check SYMBOL_COUNT is reasonable before use
  * Check SYMBOLS.length is reasonable before use
  * Check SYMBOLS is reasonable before use

* Input validation
  * DONE-Warn if master pass length < WARN_MASTER_PASS_LENGTH
  * ???-Fail if master pass length < MIN_MASTER_PASS_LENGTH

* Output password
  * DONE-Fixed length (PASS_LENGTH_SYMBOLS) - gen too long then truncate
  * DONE-Copy password to clipboard (only for single passwords)
  * DONE-Erase password from clipboard after WIPE_CLIPBOARD_DELAY seconds
  * Guarantee specified bits of randomness (SYMBOL_COUNT, PASS_LENGTH)
