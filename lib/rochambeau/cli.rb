# typed: strict
# frozen_string_literal: true

require_relative '../rochambeau'
require_relative '../rochambeau/option'

class Rochambeau
  class Cli
    extend T::Sig

    sig { void }
    def main
      choice = input_choice
      random = Rochambeau::Option.random

      puts "Bot: #{random}"
      puts "You: #{choice}"
      puts '------'

      puts Option.explain(choice, random) unless random == choice

      case choice <=> random
      when 1
        puts 'You won!'
      when -1
        puts 'Bot won!'
        puts 'Better luck next time.'
      else
        puts 'Match draw.'
      end
    end

    private

    sig { returns(Rochambeau::Option) }
    def input_choice
      # Generate message from available options.
      message = ''
      options = Rochambeau::Option.values(Option::GROUP_BASIC)
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

    sig { params(message: String).returns(String) }
    def input(message)
      puts "#{message}\n" unless message.nil?
      gets.chomp
    end
  end
end
