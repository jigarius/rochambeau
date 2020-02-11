# typed: true
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
    def main
      @choice = nil
      while @choice.nil?
        initial = input 'Rock (r), Paper (p) or Scissors (s)?'
        begin
          @choice = Rochambeau::Option.from_initial initial
        rescue Rochambeau::InvalidOptionError => e
          puts "It's simple! Type r or p or s and press ENTER." if @choice.nil?
        end
      end

      @random = Rochambeau::Option.random

      puts "Bot: #{@random.value}"
      puts "You: #{@choice.value}"

      # Determine results.
      outcome = Rochambeau::Option.compare @choice, @random
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
    def input(message)
      puts message + "\n" unless message.nil?
      gets.chomp
    end
  end
end
