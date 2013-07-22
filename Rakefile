require 'rake'
require File.expand_path('../lib/http_mini', __FILE__)

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

task :default => :install
