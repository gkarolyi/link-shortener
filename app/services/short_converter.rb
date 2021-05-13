module ShortConverter
  class ConverterBase
    ALPHABET = (('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a).freeze

    def self.base
      ALPHABET.length
    end
  end

  class Encoder < ConverterBase
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

  class Decoder < ConverterBase
    def self.call(short)
      i = 0
      short.each_char { |char| i = i * base + ALPHABET.index(char) }
      i
    end
  end
end
