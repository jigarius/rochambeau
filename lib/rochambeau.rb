# frozen_string_literal: true

##
# Rock-Paper-Scissors Class.
class Rochambeau
  ##
  # Thrown when an invalid option is detected.
  class InvalidOptionError < StandardError
  end

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
  # Checks if the option is a valid Rock-Paper-Scissors option.
  #
  # @param [String] option
  #   An option to validate.
  #
  # @return [Boolean]
  #   True if the option is "rock", "paper" or "scissors". False otherwise.
  def self.option_valid?(option)
    [ROCK, PAPER, SCISSORS].include? option
  end

  ##
  # Compares 2 items.
  #
  # @param [String] item1
  #   Item 1.
  # @param [String] item2
  #   Item 2.
  #
  # @return int
  #   if i1 < i2 then -1
  #   if i1 = i2 then 0
  #   if i1 > i2 then +1
  def self.compare(item1, item2)
    # Validate items.
    unless option_valid?(item1) && option_valid?(item2)
      raise InvalidOptionError(
        "Arguments passed to #{__method__} must be one of #{options}."
      )
    end

    # If both items are the same.
    return 0 if item1 == item2

    # Compare the items.
    return item2 == PAPER ? -1 : 1 if item1 == ROCK
    return item2 == SCISSORS ? -1 : 1 if item1 == PAPER
    return item2 == ROCK ? -1 : 1 if item1 == SCISSORS
  end
end
