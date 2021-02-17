# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'thor'
require 'rochambeau/option'
require 'rochambeau/game_mode'
require 'rochambeau/cli'

class Rochambeau
  extend T::Sig

  VERSION = '1.9.1'

  class InvalidOptionError < StandardError
  end
end
