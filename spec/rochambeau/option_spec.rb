# typed: false
# frozen_string_literal: true

require 'rochambeau/option'

class Rochambeau
  describe Option do
    it '.values returns all options without arguments' do
      expected = [
        Option::ROCK,
        Option::PAPER,
        Option::SCISSORS,
        Option::LIZARD,
        Option::SPOCK,
      ]
      expect(Option.values).to eq(expected)
    end

    it '.values returns all options for GROUP_ADVANCED' do
      expected = [
        Option::ROCK,
        Option::PAPER,
        Option::SCISSORS,
        Option::LIZARD,
        Option::SPOCK,
      ]
      expect(Option.values(Option::GROUP_ADVANCED)).to eq(expected)
    end

    it '.values returns all options for GROUP_BASIC' do
      expected = [
        Option::ROCK,
        Option::PAPER,
        Option::SCISSORS,
      ]
      expect(Option.values(Option::GROUP_BASIC)).to eq(expected)
    end

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

    it '<=> compares options' do
      rock = Rochambeau::Option::ROCK
      paper = Rochambeau::Option::PAPER
      scissors = Rochambeau::Option::SCISSORS

      expect(rock <=> rock).to be(0)
      expect(paper <=> paper).to be(0)
      expect(scissors <=> scissors).to be(0)

      expect(rock <=> scissors).to be(1)
      expect(scissors <=> rock).to be(-1)

      expect(paper <=> scissors).to be(-1)
      expect(scissors <=> paper).to be(1)

      expect(paper <=> rock).to be(1)
      expect(rock <=> paper).to be(-1)
    end

    it '.random returns random options' do
      option = Rochambeau::Option.random
      expect(option).to be_instance_of Rochambeau::Option
    end

    it '.explain explains option comparisons' do
      rock = Rochambeau::Option::ROCK
      paper = Rochambeau::Option::PAPER
      scissors = Rochambeau::Option::SCISSORS

      expect(Option.explain(rock, paper)).to eq('Paper covers rock.')
      expect(Option.explain(paper, rock)).to eq('Paper covers rock.')

      expect(Option.explain(paper, scissors)).to eq('Scissors cut paper.')
      expect(Option.explain(scissors, paper)).to eq('Scissors cut paper.')

      expect(Option.explain(scissors, rock)).to eq('Rock crushes scissors.')
      expect(Option.explain(rock, scissors)).to eq('Rock crushes scissors.')
    end
  end
end
