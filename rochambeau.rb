# typed: strict
# frozen_string_literal: true

##
# Rochambeau: Entry-point.

require_relative 'lib/rochambeau/cli'
require 'pry-byebug'

cli = Rochambeau::Cli.new
cli.main
