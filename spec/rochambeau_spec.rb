# typed: false
# frozen_string_literal: true

require_relative '../lib/rochambeau'

describe Rochambeau do
  it '::VERSION' do
    expect(Rochambeau::VERSION).to match(/^\d+\.\d\.\d+$/)
  end

  it '::VERSION matches gemspec' do
    gemspec = Gem::Specification.load(
      "#{File.dirname(__dir__)}/rochambeau.gemspec"
    )

    expect(Rochambeau::VERSION).to eq(gemspec.version.to_s)
  end
end
