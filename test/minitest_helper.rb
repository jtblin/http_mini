if ENV.has_key?("COVERAGE")
  require 'simplecov'
  SimpleCov.start do
    add_filter "/test/"
  end
end

require 'minitest/autorun'
require 'minitest/pride'
require 'webmock/minitest'

require 'coveralls'
Coveralls.wear!