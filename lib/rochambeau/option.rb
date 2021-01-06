# typed: strict
# frozen_string_literal: true

class Rochambeau
  class Option
    extend T::Sig

    sig { returns(String) }
    attr_reader :initial, :name

    private_class_method :new

    sig { params(initial: String, name: String).void }
    def initialize(initial, name)
      @initial = initial
      @name = name
    end

    ROCK = new('r', 'rock')
    PAPER = new('p', 'paper')
    SCISSORS = new('s', 'scissors')

    sig { params(other: Option).returns(Integer) }
    def <=>(other)
      return 0 if self == other

      case [self, other]
      when [ROCK, PAPER], [PAPER, SCISSORS], [SCISSORS, ROCK] then -1
      when [PAPER, ROCK], [SCISSORS, PAPER], [ROCK, SCISSORS] then 1
      else
        raise StandardError, "Could not compare #{self} with #{other}"
      end
    end

    sig { returns(String) }
    def to_s
      @name
    end

    sig { returns(String) }
    def label
      "#{@name.capitalize} (#{@initial})"
    end

    class << self
      extend(T::Sig)

      # TODO: Maybe use a constant?
      sig { returns(T::Array[Option]) }
      def values
        [ROCK, PAPER, SCISSORS]
      end

      sig { params(initial: String).returns(Option) }
      def from_initial(initial)
        result = values.detect { |o| o.initial == initial }
        return result if result

        raise Rochambeau::InvalidOptionError, "Invalid initial '#{initial}'."
      end

      sig { returns(Option) }
      def random
        T.cast(values.sample, Option)
      end
    end
  end
end
