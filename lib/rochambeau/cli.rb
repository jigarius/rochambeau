# typed: strict
# frozen_string_literal: true

require_relative '../rochambeau'
require_relative '../rochambeau/option'

require 'sorbet-runtime'

class Rochambeau
  ##
  # Rochambeau command-line interface.
  class Cli
    extend T::Sig

    ##
    # Entry-point.
    sig { void }
    def main
      # Determine user's choice.
      choice = T.let(nil, T.nilable(Rochambeau::Option))
      while choice.nil?
        initial = input 'Rock (r), Paper (p) or Scissors (s)?'
        begin
          choice = Rochambeau::Option.from_initial initial
        rescue Rochambeau::InvalidOptionError
          puts "It's simple! Type r or p or s and press ENTER." if choice.nil?
        end
      end

      # Generate CPU choice.
      random = Rochambeau::Option.random

      puts "Bot: #{random.to_s}"
      puts "You: #{choice.to_s}"

      # Determine results.
      outcome = Rochambeau::Option.compare choice, random
      if outcome.positive?
        puts 'Yo! You won!'
      elsif outcome.negative?
        puts 'Yo! Bot won! Better luck next time.'
      else
        puts 'Match draw.'
      end
    end

    ##
    # Gets user input from the console.
    #
    # @param [String] message
    #   A message for the user. Ex: Who are you?
    sig { params(message: String).returns(String) }
    def input(message)
      puts message + "\n" unless message.nil?
      gets.chomp
    end
  end
end
