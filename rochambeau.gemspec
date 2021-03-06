# frozen_string_literal: true

require_relative 'lib/rochambeau/version'

Gem::Specification.new do |s|
  s.name = 'rochambeau'
  s.version = Rochambeau::VERSION
  s.required_ruby_version = '>= 2.7.0'
  s.summary = 'Rock, paper, scissors: Command line edition.'
  s.description = 'Command-line edition of the Rock-Paper-Scissors game.'
  s.authors = ['Jigar Mehta']
  s.email = 'hello@jigarius.com'
  s.homepage = 'https://github.com/jigarius/rochambeau'
  s.license = 'LGPL-2.1'
  s.executables << 'rochambeau'

  s.files = [
    'lib/rochambeau.rb',
    'lib/rochambeau/option.rb',
    'lib/rochambeau/game_mode.rb',
    'lib/rochambeau/cli.rb',
  ]

  s.add_dependency('sorbet-runtime')
  s.add_dependency('thor', '~> 1.0', '>= 1.0.1')
end
