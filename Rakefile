require 'rake'
require 'rake/testtask'

require File.expand_path('../lib/http_mini', __FILE__)

Rake::TestTask.new(:test) do |test|
  test.libs << 'test'
  #test.warning = true
  test.pattern = 'test/**/*_test.rb'
end

task :coverage do
  ENV['COVERAGE'] = 'true'
  Rake::Task[:test].execute
end

task :build do
  system "gem build http_mini.gemspec"
end

task :install => :build do
  system "gem install --no-ri --no-rdoc http_mini-#{HttpMini.VERSION}.gem"
end

task :server => :install do
  system "cd example/sinatra/; ruby app.rb"
end

task :release => :build do
  system "gem push http_mini-#{HttpMini.VERSION}.gem"
end

task :default => :coverage
