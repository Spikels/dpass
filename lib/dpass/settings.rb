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
  SYMBOLS = SYMBOL_SETS[SYMBOL_SET]
  SYMBOL_COUNT = SYMBOLS.length
  HASH_ITER = 4096
  PASS_LENGTH = 11 # Base 256 
  SALT_PATH = ENV['HOME']+'/.dpass'
  SALT_SIZE = 16 # in bytes - hex is double this
end
