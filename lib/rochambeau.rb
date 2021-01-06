# typed: strict
# frozen_string_literal: true

class Rochambeau
  extend T::Sig

  ##
  # App version.
  VERSION = '1.2'

  ##
  # Thrown when an invalid option is detected.
  class InvalidOptionError < StandardError
  end
end
