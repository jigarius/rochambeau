# typed: false
# frozen_string_literal: true

require_relative '../lib/rochambeau'

describe Rochambeau do
  it 'tests ::VERSION' do
    expect Rochambeau::VERSION.match(/^\d+\.\d+$/)
  end
end
