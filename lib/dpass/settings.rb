module Dpass
  SYMBOL_SET = 'Alphanumeric'
  PASS_LENGTH_SYMBOLS = 14  # Base SYMBOL_COUNT
  HASH_ITER = 4096
  WARN_MASTER_PASS_LENGTH = 10
  #MIN_MASTER_PASS_LENGTH = 8 # Need hard minimum?
  WIPE_CLIPBOARD_DELAY_IN_SECONDS = 30
  SALT_PATH = ENV['HOME']+'/.dpass'
  SALT_LENGTH_BYTES = 16 # in bytes, hex is double this
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
end
