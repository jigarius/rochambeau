# typed: strict
# frozen_string_literal: true

module Rochambeau
  class Option
    extend T::Sig

    sig { returns(String) }
    attr_reader :initial, :name, :emoji

    private_class_method :new

    sig { params(initial: String, name: String, emoji: String).void }
    def initialize(initial, name, emoji)
      @initial = initial
      @name = name
      @emoji = emoji
    end

    ROCK = T.let(new('r', 'rock', "\u{1FAA8}"), Option)
    PAPER = T.let(new('p', 'paper', "\u{1F4C3}"), Option)
    SCISSORS = T.let(new('s', 'scissors', "\u{2702}"), Option)
    LIZARD = T.let(new('l', 'lizard', "\u{1F98E}"), Option)
    SPOCK = T.let(new('v', 'spock', "\u{1F596}"), Option)

    ALL = T.let(
      [ROCK, PAPER, SCISSORS, LIZARD, SPOCK],
      T::Array[Option]
    )

    OUTCOMES = T.let(
      {
        ROCK => {
          ROCK => { result: 0, explanation: nil },
          PAPER => { result: -1, explanation: 'Paper covers rock.' },
          SCISSORS => { result: 1, explanation: 'Rock crushes scissors.' },
          LIZARD => { result: 1, explanation: 'Rock crushes lizard.' },
          SPOCK => { result: -1, explanation: 'Spock vaporizes rock.' }
        },
        PAPER => {
          ROCK => { result: 1, explanation: 'Paper covers rock.' },
          PAPER => { result: 0, explanation: nil },
          SCISSORS => { result: -1, explanation: 'Scissors cut paper.' },
          LIZARD => { result: -1, explanation: 'Lizard eats paper.' },
          SPOCK => { result: 1, explanation: 'Paper disproves Spock.' }
        },
        SCISSORS => {
          ROCK => { result: -1, explanation: 'Rock crushes scissors.' },
          PAPER => { result: 1, explanation: 'Scissors cut paper.' },
          SCISSORS => { result: 0, explanation: nil },
          LIZARD => { result: 1, explanation: 'Scissors decapitate lizard.' },
          SPOCK => { result: -1, explanation: 'Spock smashes scissors.' }
        },
        LIZARD => {
          ROCK => { result: -1, explanation: 'Rock crushes lizard.' },
          PAPER => { result: 1, explanation: 'Lizard eats paper.' },
          SCISSORS => { result: -1, explanation: 'Scissors decapitate lizard.' },
          LIZARD => { result: 0, explanation: nil },
          SPOCK => { result: 1, explanation: 'Lizard poisons Spock.' }
        },
        SPOCK => {
          ROCK => { result: 1, explanation: 'Spock vaporizes rock.' },
          PAPER => { result: -1, explanation: 'Paper disproves Spock.' },
          SCISSORS => { result: 1, explanation: 'Spock smashes scissors.' },
          LIZARD => { result: -1, explanation: 'Lizard poisons Spock.' },
          SPOCK => { result: 0, explanation: nil }
        }
      },
      T::Hash[
        Option,
        T::Hash[
          Option,
          { result: Integer, explanation: T.nilable(String) }
        ]
      ]
    )
    private_constant(:OUTCOMES)

    sig { params(other: Option).returns(Integer) }
    def <=>(other)
      unless OUTCOMES[self] && T.must(OUTCOMES[self])[other]
        raise StandardError, "Could not compare #{self} with #{other}"
      end

      T.must(T.must(OUTCOMES[self])[other])[:result]
    end

    sig { returns(String) }
    def to_s
      "#{@name} #{@emoji}"
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
        unless OUTCOMES[option1] && T.must(OUTCOMES[option1])[option2]
          raise StandardError, "Unexpected combination: #{option1}, #{option2}"
        end

        T.must(T.must(OUTCOMES[option1])[option2])[:explanation]
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
