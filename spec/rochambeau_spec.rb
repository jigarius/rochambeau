# frozen_string_literal: true

require_relative '../lib/rochambeau'

describe Rochambeau do
  it 'tests ::option_valid?' do
    expect(Rochambeau.option_valid?(Rochambeau::ROCK)).to be true
    expect(Rochambeau.option_valid?(Rochambeau::PAPER)).to be true
    expect(Rochambeau.option_valid?(Rochambeau::SCISSORS)).to be true
    expect(Rochambeau.option_valid?('Fork')).to be false
  end

  it 'tests ::compare rock beats scissors' do
    result = Rochambeau.compare Rochambeau::ROCK, Rochambeau::SCISSORS
    expect(result).to be > 0
  end

  it 'tests ::compare scissors beat paper' do
    result = Rochambeau.compare Rochambeau::SCISSORS, Rochambeau::PAPER
    expect(result).to be > 0
  end

  it 'tests ::compare paper beats rock' do
    result = Rochambeau.compare Rochambeau::PAPER, Rochambeau::ROCK
    expect(result).to be > 0
  end
end
