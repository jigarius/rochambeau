# typed: strict
# frozen_string_literal: true

require_relative '../rochambeau'
require_relative '../rochambeau/option'

class Rochambeau
  class Cli
    extend T::Sig

    ##
    # Entry-point.
    sig { void }
    def main
      choice = input_choice
      random = Rochambeau::Option.random

      puts "Bot: #{random}"
      puts "You: #{choice}"

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

    private

    ##
    # Gets the user's choice.
    sig { returns(Rochambeau::Option) }
    def input_choice
      # Generate message from available options.
      message = ''
      options = Rochambeau::Option.values
      options.each_with_index do |option, index|
        glue = ', '
        case index
        when options.length - 1 then glue = ''
        when options.length - 2 then glue = ' or '
        end
        message += "#{option.label}#{glue}"
      end

      choice = T.let(nil, T.nilable(Rochambeau::Option))
      while choice.nil?
        initial = input message
        begin
          choice = Rochambeau::Option.from_initial initial
        rescue Rochambeau::InvalidOptionError
          puts "That doesn't look right. Try again." if choice.nil?
        end
      end

      choice
    end

    ##
    # Gets user input from the console.
    #
    # @param [String] message
    #   A message for the user. Ex: Who are you?
    sig { params(message: String).returns(String) }
    def input(message)
      puts "#{message}\n" unless message.nil?
      gets.chomp
    end
  end
end
