# typed: false
# frozen_string_literal: true

require_relative '../../lib/rochambeau/option'

describe Rochambeau::Option do
  it 'tests #initialize' do
    expect(Rochambeau::Option::ROCK.to_s).to eql 'rock'
    expect(Rochambeau::Option::PAPER.to_s).to eql 'paper'
    expect(Rochambeau::Option::SCISSORS.to_s).to eql 'scissors'
    expect { Rochambeau::Option.new('fork') }
      .to raise_exception RuntimeError
  end

  it 'tests #from_initial' do
    expect(Rochambeau::Option.from_initial('r').to_s).to eql 'rock'
    expect(Rochambeau::Option.from_initial('p').to_s).to eql 'paper'
    expect(Rochambeau::Option.from_initial('s').to_s).to eql 'scissors'
    expect { Rochambeau::Option.from_initial('f') }.to raise_exception "Invalid initial 'f'."
  end

  it 'tests #initial' do
    expect(Rochambeau::Option::ROCK.initial).to eql 'r'
    expect(Rochambeau::Option::PAPER.initial).to eql 'p'
    expect(Rochambeau::Option::SCISSORS.initial).to eql 's'
  end

  it 'tests #label' do
    expect(Rochambeau::Option::ROCK.label).to eql 'Rock (r)'
    expect(Rochambeau::Option::PAPER.label).to eql 'Paper (p)'
    expect(Rochambeau::Option::SCISSORS.label).to eql 'Scissors (s)'
  end

  it 'tests #compare' do
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

  it 'tests ::random' do
    option = Rochambeau::Option.random
    expect(option).to be_instance_of Rochambeau::Option
  end
end
