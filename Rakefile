desc "Builds the GEM and installs it for testing."
task :build do
  sh 'mkdir -p dist'
  sh 'gem build rochambeau.gemspec --output=dist/rochambeau.gem'
  sh 'gem install dist/rochambeau.gem'
end
