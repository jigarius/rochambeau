# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

##
# Rock-Paper-Scissors Class.
class Rochambeau
  extend T::Sig

  ##
  # Thrown when an invalid option is detected.
  class InvalidOptionError < StandardError
  end
end
