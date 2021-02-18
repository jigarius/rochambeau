# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'thor'

require_relative 'rochambeau/option'
require_relative 'rochambeau/game_mode'
require_relative 'rochambeau/cli'

module Rochambeau
  extend T::Sig

  VERSION = '1.9.2'

  class InvalidOptionError < StandardError
  end
end
