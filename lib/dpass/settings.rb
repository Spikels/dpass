module Dpass
  SYMBOL_SETS = {
    'Printable'=>"!\"\#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~",
    'Selectable'=>"+-./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ\\_abcdefghijklmnopqrstuvwxyz~",
    'Alphanumeric'=>"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz",
    'Alphabet'=>"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz",
    'AlphanumericUppercase'=>"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ",
    'AlphanumericLowercase'=>"0123456789abcdefghijklmnopqrstuvwxyz",
    'AlphabetUppercase'=>"ABCDEFGHIJKLMNOPQRSTUVWXYZ",
    'AlphabetLowercase'=>"abcdefghijklmnopqrstuvwxyz",
    'HexadecimalUppercase'=>"0123456789ABCDEF",
    'HexadecimalLowercase'=>"0123456789abcdef",
    'Numerals'=>"0123456789"}
  SYMBOL_SET = 'Alphanumeric'
  SYMBOLS = SYMBOL_SETS[SYMBOL_SET]  #  *** CALC - NOT SETTING! ***
  SYMBOL_COUNT = SYMBOLS.length  #  *** CALC - NOT SETTING! ***
  HASH_ITER = 4096
  PASS_LENGTH_SYMBOLS = 14  # Base SYMBOL_COUNT
  # NEED TO CALCULATE REQUIRED BYTE LENGTH (ROUNDING UP!)
  PASS_LENGTH_BYTES = 12  # Base 256 *** CALC - NOT SETTING! ***
  SALT_PATH = ENV['HOME']+'/.dpass'
  SALT_SIZE = 16 # in bytes - hex is double this
  MIN_MASTER_PASS_LENGTH = 8
  WARN_MASTER_PASS_LENGTH = 10
  WIPE_CLIPBOARD_DELAY = 30
end
