# typed: strict
# frozen_string_literal: true

##
# Rochambeau: Entry-point.

require_relative 'lib/rochambeau/cli'

cli = Rochambeau::Cli.new
cli.main
