# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

class Rochambeau
  ##
  # Rochambeau Option.
  class Option < T::Enum
    extend T::Sig

    ##
    # Generates values for each available option.
    enums do
      ROCK = new
      PAPER = new
      SCISSORS = new
    end

    sig { returns(String) }
    def to_s
      case self
      when ROCK then 'rock'
      when PAPER then 'paper'
      when SCISSORS then 'scissors'
      else
        # If a new option is introduced in the future, Sorbet remind us to
        # add to handle the new option in the "case" statement.
        T.absurd(self)
      end
    end

    sig { returns(String) }
    def initial
      T.cast(to_s[0], String)
    end

    sig { returns(String) }
    def label
      "#{to_s.capitalize} (#{initial})"
    end

    class << self
      extend(T::Sig)

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
        when [ROCK, PAPER] then -1
        when [PAPER, ROCK] then 1
        when [PAPER, SCISSORS] then -1
        when [SCISSORS, PAPER] then 1
        when [SCISSORS, ROCK] then -1
        when [ROCK, SCISSORS] then 1
        else 0
        end
      end

      ##
      # Creates an Option object from it's initial.
      sig { params(initial: String).returns(Option) }
      def from_initial(initial)
        case initial.downcase
        when 'r' then ROCK
        when 'p' then PAPER
        when 's' then SCISSORS
        else
          raise Rochambeau::InvalidOptionError, "Invalid initial '#{initial}'."
        end
      end

      sig { returns(Option) }
      def random
        T.cast(values.sample, Option)
      end
    end
  end
end
