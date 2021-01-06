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

      ##
      # Compares 2 Rochambeau options.
      #
      # Returns 1 when option1 > option2
      # Returns 0 when option1 = option2
      # Returns -1 when option1 < option2
      sig do
        params(
          option1: Rochambeau::Option,
          option2: Rochambeau::Option
        ).returns(Integer)
      end
      def compare(option1, option2)
        case [option1, option2]
        when [ROCK, PAPER], [PAPER, SCISSORS], [SCISSORS, ROCK] then -1
        when [PAPER, ROCK], [SCISSORS, PAPER], [ROCK, SCISSORS] then 1
        else 0
        end
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
