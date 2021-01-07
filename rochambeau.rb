# typed: strict
# frozen_string_literal: true

##
# Rochambeau: Entry-point.

require 'sorbet-runtime'
require_relative 'lib/rochambeau/cli'

begin
  Rochambeau::Cli.start(ARGV)
rescue Interrupt
  # No op.
end
