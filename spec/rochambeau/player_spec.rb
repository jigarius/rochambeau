# typed: false
# frozen_string_literal: true

require 'rochambeau/player'
require 'rochambeau/game_mode'

module Rochambeau
  module Player
    describe Robot do
      subject { Robot.new }

      it '.name' do
        expect(subject.name).to eql('Bot')
      end

      it '.choose_option' do
        choice = subject.choose_option(GameMode::BASIC.options)
        expect(GameMode::BASIC.options).to include(choice)
      end

      it '.victory_message' do
        expect(subject.victory_message).to eql('Bot wins.')
      end
    end

    describe UnnamedHuman do
      subject { UnnamedHuman.new }

      it '.name' do
        expect(subject.name).to eql('You')
      end

      it '.victory_message' do
        expect(subject.victory_message).to eql('You win!')
      end

      it '.choose_option' do
        expect_any_instance_of(Thor::Shell::Basic)
          .to receive(:ask)
          .with('Make a choice', limited_to: ['r', 'p', 's'])
          .and_return('s')

        expect(subject.choose_option(GameMode::BASIC.options))
          .to eql(Option::SCISSORS)
      end
    end

    describe NamedHuman do
      subject { NamedHuman.new('Joey') }

      it '.name' do
        expect(subject.name).to eql('Joey')
      end

      it '.victory_message' do
        expect(subject.victory_message).to eql('Joey wins.')
      end

      it '.choose_option' do
        expect_any_instance_of(Thor::Shell::Basic)
          .to receive(:ask)
          .with('Joey, choose', limited_to: ['r', 'p', 's'])
          .and_return('s')

        expect(subject.choose_option(GameMode::BASIC.options))
          .to eql(Option::SCISSORS)
      end
    end
  end
end
