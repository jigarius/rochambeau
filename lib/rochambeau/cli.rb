# typed: strict
# frozen_string_literal: true

module Rochambeau
  class Cli < Thor
    extend T::Sig

    desc 'version', 'Display version information.'
    sig { void }
    def version
      puts <<~VERSION
        Rochambeau #{Rochambeau::VERSION}
        GitHub: https://github.com/jigarius/rochambeau
      VERSION
    end

    desc 'play', 'Play Rock-Paper-Scissors.'
    option 'advanced',
           aliases: ['a'],
           type: :boolean,
           default: false,
           desc: 'Enable the options "Lizard" and "Spock".'
    option 'players',
           aliases: ['p'],
           type: :numeric,
           enum: [1, 2],
           default: 1,
           desc: 'Choose between 1 player and 2 player modes.'
    sig { void }
    def play
      system 'clear'

      game_mode =
        options.advanced ? GameMode::ADVANCED : GameMode::BASIC
      p1, p2 = Cli.get_players(options.players)

      puts game_mode.options.map(&:label).join(' · ')
      p1_choice = p1.choose_option(game_mode.options)
      p2_choice = p2.choose_option(game_mode.options)

      puts <<~CHOICES
        ------
        #{p1.name}: #{p1_choice}
        #{p2.name}: #{p2_choice}
        ------
      CHOICES

      puts Option.explain(p1_choice, p2_choice) unless p1_choice == p2_choice

      case p1_choice <=> p2_choice
      when 1 then puts p1.victory_message
      when -1 then puts p2.victory_message
      else puts 'Match draw.'
      end
    end

    default_task :play

    sig { params(count: Integer).returns([Player, Player]) }
    def self.get_players(count)
      case count
      when 1
        return [Player::UnnamedHuman.new, Player::Robot.new]
      when 2
        return [
          Player::NamedHuman.new('Player 1'),
          Player::NamedHuman.new('Player 2'),
        ]
      end

      raise ArgumentError, "Unexpected player count: #{count}"
    end
  end
end
