# typed: strict
# frozen_string_literal: true

class Rochambeau
  extend T::Sig

  VERSION = '1.9'

  class InvalidOptionError < StandardError
  end
end
