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

    ALL = T.let(
      [ROCK, PAPER, SCISSORS, LIZARD, SPOCK],
      T::Array[Option]
    )

    sig { params(other: Option).returns(Integer) }
    def <=>(other)
      return 0 if self == other

      case [self, other]
      when [ROCK, PAPER] then -1
      when [ROCK, SCISSORS] then 1
      when [ROCK, LIZARD] then 1
      when [ROCK, SPOCK] then -1

      when [PAPER, ROCK] then 1
      when [PAPER, SCISSORS] then -1
      when [PAPER, LIZARD] then -1
      when [PAPER, SPOCK] then 1

      when [SCISSORS, ROCK] then -1
      when [SCISSORS, PAPER] then 1
      when [SCISSORS, LIZARD] then 1
      when [SCISSORS, SPOCK] then -1

      when [LIZARD, ROCK] then -1
      when [LIZARD, PAPER] then 1
      when [LIZARD, SCISSORS] then -1
      when [LIZARD, SPOCK] then 1

      when [SPOCK, ROCK] then 1
      when [SPOCK, PAPER] then -1
      when [SPOCK, SCISSORS] then 1
      when [SPOCK, LIZARD] then -1
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

      sig do
        params(option1: Option, option2: Option)
          .returns(T.nilable(String))
      end
      def explain(option1, option2)
        return if option1 == option2

        case [option1, option2]
        when [ROCK, PAPER] then 'Paper covers rock.'
        when [ROCK, SCISSORS] then 'Rock crushes scissors.'
        when [ROCK, LIZARD] then 'Rock crushes lizard.'
        when [ROCK, SPOCK] then 'Spock vaporizes rock.'

        when [PAPER, ROCK] then 'Paper covers rock.'
        when [PAPER, SCISSORS] then 'Scissors cut paper.'
        when [PAPER, LIZARD] then 'Lizard eats paper.'
        when [PAPER, SPOCK] then 'Paper disproves Spock.'

        when [SCISSORS, ROCK] then 'Rock crushes scissors.'
        when [SCISSORS, PAPER] then 'Scissors cut paper.'
        when [SCISSORS, LIZARD] then 'Scissors decapitate lizard.'
        when [SCISSORS, SPOCK] then 'Spock smashes scissors.'

        when [LIZARD, ROCK] then 'Rock crushes lizard.'
        when [LIZARD, PAPER] then 'Lizard eats paper.'
        when [LIZARD, SCISSORS] then 'Scissors decapitate lizard.'
        when [LIZARD, SPOCK] then 'Lizard poisons Spock.'

        when [SPOCK, ROCK] then 'Spock vaporizes rock.'
        when [SPOCK, PAPER] then 'Paper disproves Spock.'
        when [SPOCK, SCISSORS] then 'Spock smashes scissors.'
        when [SPOCK, LIZARD] then 'Lizard poisons Spock.'
        else
          raise StandardError, "Unexpected combination: #{option1}, #{option2}"
        end
      end

      sig { params(initial: String).returns(Option) }
      def from_initial(initial)
        result = ALL.detect { |o| o.initial == initial }
        return result if result

        raise Rochambeau::InvalidOptionError, "Invalid initial '#{initial}'."
      end
    end
  end
end
