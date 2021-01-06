# typed: false
# frozen_string_literal: true

require 'rochambeau/option'

class Rochambeau
  describe Option do
    it 'can be converted to string' do
      Rochambeau::Option.values.each do |option|
        expect(option.to_s).to eql option.name
      end
    end

    it '.from_initial returns options for valid initials' do
      Rochambeau::Option.values.each do |option|
        expect(Option.from_initial(option.initial)).to eql option
      end
    end

    it '.from_initial raises for invalid initials' do
      expect { Rochambeau::Option.from_initial('f') }
        .to raise_error(Rochambeau::InvalidOptionError, "Invalid initial 'f'.")
    end

    it '.initial returns identifier' do
      expect(Rochambeau::Option::ROCK.initial).to eql 'r'
      expect(Rochambeau::Option::PAPER.initial).to eql 'p'
      expect(Rochambeau::Option::SCISSORS.initial).to eql 's'
    end

    it '.label returns label' do
      expect(Rochambeau::Option::ROCK.label).to eql 'Rock (r)'
      expect(Rochambeau::Option::PAPER.label).to eql 'Paper (p)'
      expect(Rochambeau::Option::SCISSORS.label).to eql 'Scissors (s)'
    end

    it 'compares options correctly' do
      rock = Rochambeau::Option::ROCK
      paper = Rochambeau::Option::PAPER
      scissors = Rochambeau::Option::SCISSORS

      # Test rock beats scissors.
      result = Rochambeau::Option.compare(rock, scissors)
      expect(result).to be > 0

      # Test scissors beat paper.
      result = Rochambeau::Option.compare(scissors, paper)
      expect(result).to be > 0

      # Test paper beats rock.
      result = Rochambeau::Option.compare(paper, rock)
      expect(result).to be > 0
    end

    it '.random returns random options' do
      option = Rochambeau::Option.random
      expect(option).to be_instance_of Rochambeau::Option
    end
  end
end
