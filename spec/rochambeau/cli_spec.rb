# typed: ignore
# frozen_string_literal: true

module Rochambeau
  describe Cli do
    it '.version' do
      expected =  <<~VERSION
        Rochambeau #{Rochambeau::VERSION}
        GitHub: https://github.com/jigarius/rochambeau
      VERSION

      expect { Cli.start(['version']) }.to output(expected).to_stdout
    end

    context 'advanced mode' do
      it '.play uses advanced options' do
        expect_any_instance_of(Player::UnnamedHuman)
          .to receive(:choose_option)
          .with(GameMode::ADVANCED.options)
          .and_return(Option::SPOCK)

        expect_any_instance_of(Player::Robot)
          .to receive(:choose_option)
          .with(GameMode::ADVANCED.options)
          .and_return(Option::LIZARD)

        expected = <<~OUTPUT
          Rock (r) · Paper (p) · Scissors (s) · Lizard (l) · Spock (v)
          ------
          You: spock
          Bot: lizard
          ------
          Lizard poisons Spock.
          Bot wins.
        OUTPUT

        expect { Cli.start(['play', '--advanced']) }.to output(expected).to_stdout
      end
    end

    context '1 player game' do
      context 'human wins' do
        it '.play' do
          expect_any_instance_of(Player::UnnamedHuman)
            .to receive(:choose_option)
            .with(GameMode::BASIC.options)
            .and_return(Option::PAPER)

          expect_any_instance_of(Player::Robot)
            .to receive(:choose_option)
            .with(GameMode::BASIC.options)
            .and_return(Option::ROCK)

          expected = <<~OUTPUT
            Rock (r) · Paper (p) · Scissors (s)
            ------
            You: paper
            Bot: rock
            ------
            Paper covers rock.
            You win!
          OUTPUT

          expect { Cli.start(['play', '-p', '1']) }.to output(expected).to_stdout
        end
      end

      context 'robot wins' do
        it '.play' do
          expect_any_instance_of(Player::UnnamedHuman)
            .to receive(:choose_option)
            .with(GameMode::BASIC.options)
            .and_return(Option::PAPER)

          expect_any_instance_of(Player::Robot)
            .to receive(:choose_option)
            .with(GameMode::BASIC.options)
            .and_return(Option::SCISSORS)

          expected = <<~OUTPUT
            Rock (r) · Paper (p) · Scissors (s)
            ------
            You: paper
            Bot: scissors
            ------
            Scissors cut paper.
            Bot wins.
          OUTPUT

          expect { Cli.start(['play', '-p', '1']) }.to output(expected).to_stdout
        end
      end

      context 'match draw' do
        it '.play' do
          expect_any_instance_of(Player::UnnamedHuman)
            .to receive(:choose_option)
            .with(GameMode::BASIC.options)
            .and_return(Option::SCISSORS)

          expect_any_instance_of(Player::Robot)
            .to receive(:choose_option)
            .with(GameMode::BASIC.options)
            .and_return(Option::SCISSORS)

          expected = <<~OUTPUT
            Rock (r) · Paper (p) · Scissors (s)
            ------
            You: scissors
            Bot: scissors
            ------
            Match draw.
          OUTPUT

          expect { Cli.start(['play', '-p', '1']) }.to output(expected).to_stdout
        end
      end
    end

    context '2 player game' do
      context 'player 1 wins' do
        it '.play' do
          p1, p2 = Cli.get_players(2)
          expect(p1).to receive(:choose_option).with(GameMode::BASIC.options).and_return(Option::ROCK)
          expect(p2).to receive(:choose_option).with(GameMode::BASIC.options).and_return(Option::SCISSORS)
          expect(Cli).to receive(:get_players).and_return([p1, p2])

          expected = <<~OUTPUT
            Rock (r) · Paper (p) · Scissors (s)
            ------
            Player 1: rock
            Player 2: scissors
            ------
            Rock crushes scissors.
            Player 1 wins.
          OUTPUT

          expect { Cli.start(['play', '-p', '2']) }.to output(expected).to_stdout
        end
      end

      context 'player 2 wins' do
        it '.play' do
          p1, p2 = Cli.get_players(2)
          expect(p1).to receive(:choose_option).with(GameMode::BASIC.options).and_return(Option::ROCK)
          expect(p2).to receive(:choose_option).with(GameMode::BASIC.options).and_return(Option::PAPER)
          expect(Cli).to receive(:get_players).and_return([p1, p2])

          expected = <<~OUTPUT
            Rock (r) · Paper (p) · Scissors (s)
            ------
            Player 1: rock
            Player 2: paper
            ------
            Paper covers rock.
            Player 2 wins.
          OUTPUT

          expect { Cli.start(['play', '-p', '2']) }.to output(expected).to_stdout
        end
      end

      context 'match draw' do
        it '.play' do
          p1, p2 = Cli.get_players(2)
          expect(p1).to receive(:choose_option).with(GameMode::BASIC.options).and_return(Option::ROCK)
          expect(p2).to receive(:choose_option).with(GameMode::BASIC.options).and_return(Option::ROCK)
          expect(Cli).to receive(:get_players).and_return([p1, p2])

          expected = <<~OUTPUT
            Rock (r) · Paper (p) · Scissors (s)
            ------
            Player 1: rock
            Player 2: rock
            ------
            Match draw.
          OUTPUT

          expect { Cli.start(['play', '-p', '2']) }.to output(expected).to_stdout
        end
      end
    end
  end
end
