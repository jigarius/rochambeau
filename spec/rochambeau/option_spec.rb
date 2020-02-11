# typed: false
# frozen_string_literal: true

require_relative '../../lib/rochambeau/option'

describe Rochambeau::Option do
  it 'tests ::initialize' do
    expect(Rochambeau::Option.new('rock').value).to eql 'rock'
    expect(Rochambeau::Option.new('paper').value).to eql 'paper'
    expect(Rochambeau::Option.new('scissors').value).to eql 'scissors'
    expect { Rochambeau::Option.new('fork') }
      .to raise_exception "Invalid value 'fork'."
  end

  it 'tests ::from_initial' do
    expect(Rochambeau::Option.from_initial('r').value).to eql 'rock'
    expect(Rochambeau::Option.from_initial('p').value).to eql 'paper'
    expect(Rochambeau::Option.from_initial('s').value).to eql 'scissors'
    expect { Rochambeau::Option.from_initial('f') }.to raise_exception "Invalid initial 'f'."
  end

  it 'tests ::valid?' do
    expect(Rochambeau::Option.valid?('rock')).to be true
    expect(Rochambeau::Option.valid?('paper')).to be true
    expect(Rochambeau::Option.valid?('scissors')).to be true
    expect(Rochambeau::Option.valid?('fork')).to be false
  end

  it 'tests ::initial' do
    option_rock = Rochambeau::Option.new 'rock'
    expect(option_rock.initial).to eql 'r'

    option_paper = Rochambeau::Option.new 'paper'
    expect(option_paper.initial).to eql 'p'

    option_scissors = Rochambeau::Option.new 'scissors'
    expect(option_scissors.initial).to eql 's'
  end

  it 'tests ::compare' do
    rock = Rochambeau::Option.new 'rock'
    paper = Rochambeau::Option.new 'paper'
    scissors = Rochambeau::Option.new 'scissors'

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
