# typed: false
# frozen_string_literal: true

module Rochambeau
  describe GameMode do
    it '.options returns options' do
      expect(GameMode::BASIC.options).to eq([
        Option::ROCK,
        Option::PAPER,
        Option::SCISSORS,
      ])

      expect(GameMode::ADVANCED.options).to eq(Option::ALL)
    end

    it '.new is not allowed' do
      expect { GameMode.new([Option::ROCK]) }.to raise_error(NoMethodError)
    end
  end
end
