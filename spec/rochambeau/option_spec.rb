# typed: false
# frozen_string_literal: true

module Rochambeau
  describe Option do
    it '.new is not allowed' do
      expect { Option.new('f', 'fork') }
        .to raise_error(NoMethodError)
    end

    it '#ALL' do
      expect(Option::ALL.length).to eq(5)
    end

    it '.to_s returns name' do
      Rochambeau::Option::ALL.each do |option|
        expect(option.to_s).to eql option.name
      end
    end

    it '.from_initial returns options for valid initials' do
      Rochambeau::Option::ALL.each do |option|
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
      expect(Rochambeau::Option::LIZARD.initial).to eql 'l'
      expect(Rochambeau::Option::SPOCK.initial).to eql 'v'
    end

    it '.name returns name' do
      expect(Rochambeau::Option::ROCK.name).to eql 'rock'
      expect(Rochambeau::Option::PAPER.name).to eql 'paper'
      expect(Rochambeau::Option::SCISSORS.name).to eql 'scissors'
      expect(Rochambeau::Option::LIZARD.name).to eql 'lizard'
      expect(Rochambeau::Option::SPOCK.name).to eql 'spock'
    end

    it '.label returns label' do
      expect(Rochambeau::Option::ROCK.label).to eql 'Rock (r)'
      expect(Rochambeau::Option::PAPER.label).to eql 'Paper (p)'
      expect(Rochambeau::Option::SCISSORS.label).to eql 'Scissors (s)'
      expect(Rochambeau::Option::LIZARD.label).to eql 'Lizard (l)'
      expect(Rochambeau::Option::SPOCK.label).to eql 'Spock (v)'
    end

    it '<=> compares options' do
      rock = Rochambeau::Option::ROCK
      paper = Rochambeau::Option::PAPER
      scissors = Rochambeau::Option::SCISSORS
      lizard = Rochambeau::Option::LIZARD
      spock = Rochambeau::Option::SPOCK

      # Rock
      expect(rock <=> rock).to be(0)
      expect(rock <=> scissors).to be(1)
      expect(rock <=> paper).to be(-1)
      expect(rock <=> lizard).to be(1)
      expect(rock <=> spock).to be(-1)

      # Paper
      expect(paper <=> rock).to be(1)
      expect(paper <=> paper).to be(0)
      expect(paper <=> scissors).to be(-1)
      expect(paper <=> lizard).to be(-1)
      expect(paper <=> spock).to be(1)

      # Scissors
      expect(scissors <=> rock).to be(-1)
      expect(scissors <=> paper).to be(1)
      expect(scissors <=> scissors).to be(0)
      expect(scissors <=> lizard).to be(1)
      expect(scissors <=> spock).to be(-1)

      # Lizard
      expect(lizard <=> rock).to be(-1)
      expect(lizard <=> paper).to be(1)
      expect(lizard <=> scissors).to be(-1)
      expect(lizard <=> lizard).to be(0)
      expect(lizard <=> spock).to be(1)

      # Spock
      expect(spock <=> rock).to be(1)
      expect(spock <=> paper).to be(-1)
      expect(spock <=> scissors).to be(1)
      expect(spock <=> lizard).to be(-1)
      expect(spock <=> spock).to be(0)
    end

    it '.explain explains option comparisons' do
      rock = Rochambeau::Option::ROCK
      paper = Rochambeau::Option::PAPER
      scissors = Rochambeau::Option::SCISSORS
      lizard = Rochambeau::Option::LIZARD
      spock = Rochambeau::Option::SPOCK

      expect(Option.explain(rock, rock)).to be_nil
      expect(Option.explain(rock, paper)).to eq('Paper covers rock.')
      expect(Option.explain(rock, scissors)).to eq('Rock crushes scissors.')
      expect(Option.explain(rock, lizard)).to eq('Rock crushes lizard.')
      expect(Option.explain(rock, spock)).to eq('Spock vaporizes rock.')

      expect(Option.explain(paper, rock)).to eq('Paper covers rock.')
      expect(Option.explain(paper, paper)).to be_nil
      expect(Option.explain(paper, scissors)).to eq('Scissors cut paper.')
      expect(Option.explain(paper, lizard)).to eq('Lizard eats paper.')
      expect(Option.explain(paper, spock)).to eq('Paper disproves Spock.')

      expect(Option.explain(scissors, rock)).to eq('Rock crushes scissors.')
      expect(Option.explain(scissors, paper)).to eq('Scissors cut paper.')
      expect(Option.explain(scissors, scissors)).to be_nil
      expect(Option.explain(scissors, lizard)).to eq('Scissors decapitate lizard.')
      expect(Option.explain(scissors, spock)).to eq('Spock smashes scissors.')

      expect(Option.explain(lizard, rock)).to eq('Rock crushes lizard.')
      expect(Option.explain(lizard, paper)).to eq('Lizard eats paper.')
      expect(Option.explain(lizard, scissors)).to eq('Scissors decapitate lizard.')
      expect(Option.explain(lizard, lizard)).to be_nil
      expect(Option.explain(lizard, spock)).to eq('Lizard poisons Spock.')

      expect(Option.explain(spock, rock)).to eq('Spock vaporizes rock.')
      expect(Option.explain(spock, paper)).to eq('Paper disproves Spock.')
      expect(Option.explain(spock, scissors)).to eq('Spock smashes scissors.')
      expect(Option.explain(spock, lizard)).to eq('Lizard poisons Spock.')
      expect(Option.explain(spock, spock)).to be_nil
    end

    it '.explain can explain all option combinations' do
      Option::ALL.each do |option1|
        Option::ALL.each do |option2|
          if option1 == option2
            expect(Option.explain(option1, option2)).to be_nil
          else
            expect(Option.explain(option1, option2)).not_to be_nil
          end
        end
      end
    end
  end
end
