# frozen_string_literal: true

desc 'Builds the gem and installs it for testing.'
task :build do
  sh 'mkdir -p dist'
  sh 'gem build rochambeau.gemspec --output=dist/rochambeau.gem'
  sh 'gem install dist/rochambeau.gem'
end

desc 'Builds the gem and pushes it to rubygems.org'
task :release do
  Rake::Task['build'].invoke
  sh 'gem push dist/rochambeau.gem'
end
