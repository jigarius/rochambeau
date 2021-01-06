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

    ROCK = T.let(new('r', 'rock'), Option)
    PAPER = T.let(new('p', 'paper'), Option)
    SCISSORS = T.let(new('s', 'scissors'), Option)
    LIZARD = T.let(new('l', 'lizard'), Option)
    SPOCK = T.let(new('v', 'spock'), Option)

    GROUP_BASIC = 'b'
    GROUP_ADVANCED = 'a'

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
      sig do
        params(group: String)
          .returns(T::Array[Option])
      end
      def values(group = GROUP_ADVANCED)
        case group
        when GROUP_BASIC
          [ROCK, PAPER, SCISSORS]
        when GROUP_ADVANCED
          [ROCK, PAPER, SCISSORS, LIZARD, SPOCK]
        else
          T.absurd(group)
        end
      end

      sig do
        params(option1: Option, option2: Option)
          .returns(T.nilable(String))
      end
      def explain(option1, option2)
        return if option1 == option2

        case [option1, option2]
        when [ROCK, PAPER], [PAPER, ROCK]
          'Paper covers rock.'
        when [PAPER, SCISSORS], [SCISSORS, PAPER]
          'Scissors cut paper.'
        when [SCISSORS, ROCK], [ROCK, SCISSORS]
          'Rock crushes scissors.'
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
