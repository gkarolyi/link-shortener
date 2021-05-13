module ShortConverter
  ##
  # Base service class which provides an alphabet 
  # and a class method for checking its length.
  class ConverterBase
    ALPHABET = (('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a).freeze

    def self.base
      ALPHABET.length
    end
  end

  ##
  # Service class for encoding numbers into strings.
  class Encoder < ConverterBase
    # Bijective function which takes an id
    # (Integer) and returns its base64 equivalent (String)
    def self.call(id)
      return ALPHABET.first if id.zero?

      s = ''
      while id.positive?
        s << ALPHABET[id % base]
        id /= base
      end

      s.reverse
    end
  end

  ##
  # Service class for decoding strings into numbers.
  class Decoder < ConverterBase
    # Bijective function which takes
    # a base64 shortcode (String) and returns its base10
    # equivalent (Integer).
    def self.call(short)
      i = 0
      short.each_char { |char| i = i * base + ALPHABET.index(char) }
      i
    end
  end
end
