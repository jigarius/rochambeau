# typed: false
# frozen_string_literal: true

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

  it '.execute calls Cli.start(ARGV)' do
    expect(Rochambeau::Cli).to receive(:start).with(ARGV).and_return(true)

    Rochambeau.execute
  end

  context 'on interrupt' do
    it '.execute exists gracefully' do
      expect(Rochambeau::Cli)
        .to receive(:start)
        .and_raise(Interrupt)

      expect { Rochambeau.execute }.to output('').to_stdout
    end
  end

  context 'on argument error' do
    it '.execute exists gracefully' do
      expect(Rochambeau::Cli)
        .to receive(:start)
        .and_raise(ArgumentError, 'Illegal argument --foobar')

      expect { Rochambeau.execute }
        .to output("Illegal argument --foobar\n").to_stderr
    end
  end
end
