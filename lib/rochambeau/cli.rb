# typed: strict
# frozen_string_literal: true

require 'thor'

require_relative '../rochambeau'
require_relative '../rochambeau/option'
require_relative '../rochambeau/game_mode'

class Rochambeau
  class Cli < Thor
    extend T::Sig

    desc 'play', 'Play Rock-Paper-Scissors.'
    option 'advanced',
           aliases: ['a'],
           type: :boolean,
           default: false,
           desc: 'Advanced mode contains the options "Lizard" and "Spock".'
    sig { void }
    def play
      game_mode =
        options.advanced ? GameMode::ADVANCED : GameMode::BASIC

      choice = input_choice(game_mode)
      random = T.cast(game_mode.options.sample, Option)

      puts '------'
      puts "Bot: #{random}"
      puts "You: #{choice}"
      puts '------'

      puts Option.explain(choice, random) unless random == choice

      case choice <=> random
      when 1
        puts 'You won (:'
      when -1
        puts 'Bot won :('
        puts 'Better luck next time.'
      else
        puts 'Match draw.'
      end
    end

    default_task :play

    private

    no_commands do
      sig { params(game_mode: GameMode).returns(Rochambeau::Option) }
      def input_choice(game_mode)
        puts game_mode.options.map(&:label).join(' · ')
        chosen_initial = ask('Make a choice', {
          limited_to: game_mode.options.map(&:initial)
        })
        Rochambeau::Option.from_initial chosen_initial
      end
    end
  end
end
