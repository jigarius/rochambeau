# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

class Rochambeau
  ##
  # Rochambeau command-line interface.
  class Option
    extend T::Sig

    attr_reader :value

    ##
    # Rock.
    ROCK = 'rock'

    ##
    # Paper.
    PAPER = 'paper'

    ##
    # Scissors.
    SCISSORS = 'scissors'

    ##
    # Creates an Option object.
    #
    # @param [String] value
    #   Value of the option. One of ROCK, PAPER, SCISSORS.
    def initialize(value)
      value = value.downcase
      unless self.class.valid?(value)
        raise Rochambeau::InvalidOptionError, "Invalid value '#{value}'."
      end

      @value = value
    end

    ##
    # Returns an initial for the option.
    #
    # @return [String]
    #   One of r, p, s.
    def initial
      @value[0]
    end

    ##
    # Creates an Option from option initial.
    #
    # @param [String] initial
    #   An option initial, e.g. r, p, s.
    def self.from_initial(initial)
      case initial.downcase
      when 'r' then value = ROCK
      when 'p' then value = PAPER
      when 's' then value = SCISSORS
      end

      if value.nil?
        raise Rochambeau::InvalidOptionError, "Invalid initial '#{initial}'."
      end

      new value
    end

    ##
    # Get rock-paper-scissors options.
    #
    # @return [Array]
    #   An array containing Rock-Paper-Scissors options.
    def self.options
      [ROCK, PAPER, SCISSORS]
    end

    ##
    # Rock Paper Scissors?
    #
    # @return [String]
    #   Random "rock", "paper" or "scissors".
    def self.random
      new options.sample
    end

    ##
    # Checks if the option is a valid Rock-Paper-Scissors option.
    #
    # @param [String] option
    #   An option to validate.
    #
    # @return [Boolean]
    #   True if the option is "rock", "paper" or "scissors". False otherwise.
    def self.valid?(option)
      options.include? option
    end

    ##
    # Compares 2 options.
    #
    # @param [Rochambeau::Option] option1
    #   Item 1.
    # @param [Rochambeau::Option] option2
    #   Item 2.
    #
    # @return [Integer]
    #   if option1 < option2 then -1
    #   if option1 = option2 then 0
    #   if option1 > option2 then +1
    def self.compare(option1, option2)
      # If both items are the same.
      return 0 if option1.value == option2.value

      # Compare the items.
      return option2.value == PAPER ? -1 : 1 if option1.value == ROCK
      return option2.value == SCISSORS ? -1 : 1 if option1.value == PAPER
      return option2.value == ROCK ? -1 : 1 if option1.value == SCISSORS
    end
  end
end
