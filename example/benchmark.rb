# Usage
#    rake server
#    ruby example/benchmark.rb
#
# user     system      total        real
# HttpMini n = 1000
# 1.380000   0.350000   1.730000 (  9.118878)
# RestClient n = 1000
# 1.110000   0.370000   1.480000 ( 11.173376)
#

require 'benchmark'
require 'http_mini'
gem 'rest-client'
require 'rest-client'

n = 1000

Benchmark.bm do |x|
  puts "HttpMini n = #{n}"
  x.report { n.times do   ; HttpMini.new('http://localhost:4567/').get end }
  puts "RestClient n = #{n}"
  x.report { n.times do   ; RestClient.get('http://localhost:4567/') end }
end

