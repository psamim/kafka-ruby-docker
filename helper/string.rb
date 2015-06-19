# http://stackoverflow.com/questions/1235863/test-if-a-string-is-basically-an-integer-in-quotes-using-ruby
class String
  def integer? 
    [                          # In descending order of likeliness:
      /^[-+]?[1-9]([0-9]*)?$/, # decimal
      /^0[0-7]+$/,             # octal
      /^0x[0-9A-Fa-f]+$/,      # hexadecimal
      /^0b[01]+$/              # binary
    ].each do |match_pattern|
      return true if self =~ match_pattern
    end
    return false
  end
end
