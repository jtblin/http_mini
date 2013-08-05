# -*- encoding: utf-8 -*-
require File.expand_path('../lib/http_mini', __FILE__)

Gem::Specification.new do |s|
  s.name = %q{http_mini}
  s.version = HttpMini.VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors = ["Jerome Touffe-Blin"]
  s.email = %q{jtblin@gmail.com}
  s.homepage = %q{https://github.com/jtblin/http_mini}
  s.license = %q{BSD}
  s.summary = s.description =  %q{A truly minimalist Http Ruby client}
  s.required_rubygems_version = ">= 1.3.6"
  s.add_development_dependency 'sinatra', '>= 1.3.0'
  s.add_development_dependency 'minitest', '~> 5'
  s.add_development_dependency 'webmock', '~> 1'
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md",
    "CHANGELOG.md"
  ]
  s.files = Dir.glob("{bin,lib}/**/*") + %w(LICENSE README.md CHANGELOG.md)
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]

end

