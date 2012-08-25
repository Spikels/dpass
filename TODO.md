# TODO

* Tests
  * DONE-Add Travis CI
  * Figure out how to mock the 2 file system tests
  * Add tests to new code & test frist going forward!

* Command-line
  * DONE-Allow multiple applications (i.e. dpass gmail yahoo)

* Create salt file (~/.dpass)
  * DONE-Check if file already exists. If so abort with message to delete manually if you really want a NEW salt file.
  * DONE-Generate 128-bit random salt (32 hex chars)
  * DONE-Save to file ~/.dpass
  * DONE-Set permission to 600
  * Handle File.open errors
  * Handle File.chown errors
  * ???-Append new salts so old salts are not lost (w/ date?)

* Read salt file (~/.dpass)
  * DONE-Check that file exists. If not abort with message to copy existing salt or create new salt if you REALLY want to.
  * DONE-Read salt file
  * Check that salt file has 0600 permission
  * Check salt is valid length
  * Check salt is hex
  * ???-Check that salt seems random (how?)

* Master password
  * DONE-Remove highline dependency
  * DONE-Clear from memory ASAP string.replace

* Input validation
  * Check HASH_ITER is reasonable before use
  * Check PASS_LENGTH is reasonable before use
  * Check SYMBOL_COUNT is reasonable before use
  * Check SYMBOLS.length is reasonable before use
  * Check SYMBOLS is reasonable before use
  * Check master password (min length, ???)

* Output password
  * Guarantee specified bits of randomness (SYMBOL_COUNT, PASS_LENGTH)
