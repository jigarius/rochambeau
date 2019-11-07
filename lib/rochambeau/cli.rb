# frozen_string_literal: true

class Rochambeau

  ##
  # Rochambeau command-line interface.
  class Cli
    ##
    # Rock-Paper-Scissors options.
    OPTIONS = {
      r: Rochambeau::ROCK,
      p: Rochambeau::PAPER,
      s: Rochambeau::SCISSORS
    }.freeze

    ##
    # Entry-point.
    def main
      @choice = nil
      while @choice.nil?
        letter = input 'Rock (r), Paper (p) or Scissors (s)?'
        @choice = rpc_to_choice letter
        puts "It's simple! Type r or p or s and press ENTER." if @choice.nil?
      end

      @random = random_choice

      puts "Bot: #{@random.upcase}"
      puts "You: #{@choice.upcase}"

      # Determine results.
      outcome = Rochambeau.compare @choice, @random
      if outcome.positive?
        puts 'Yo! You won!'
      elsif outcome.negative?
        puts 'Yo! Bot won! Better luck next time.'
      else
        puts 'Match draw.'
      end
    end

    def rpc_to_choice(letter)
      letter = letter.to_sym
      OPTIONS[letter] if OPTIONS.key? letter
    end

    ##
    # Rock Paper Scissors?
    #
    # @return [String]
    #   Random "rock", "paper" or "scissors".
    def random_choice
      [
        Rochambeau::ROCK,
        Rochambeau::PAPER,
        Rochambeau::SCISSORS
      ].sample
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
