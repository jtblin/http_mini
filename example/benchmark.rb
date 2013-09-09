# Usage
#    rake server
#    ruby example/benchmark.rb
#
#user     system      total        real
#RestClient n = 5000
#5.370000   1.520000   6.890000 ( 37.202423)
#HttpMini n = 5000
#3.810000   1.470000   5.280000 ( 33.375990)
#raw URI + Net::HTTP n = 5000
#3.780000   1.500000   5.280000 ( 33.239931)
#

require 'benchmark'
require Dir.pwd + '/lib/http_mini'
gem 'rest-client'
require 'rest-client'
require 'uri'

def raw_http(uri)
  u = URI.parse(uri)
  Net::HTTP.new(u.host, u.port).start do |http|
    http.get(u.path || '/')
  end
end

n = 5000
Benchmark.bm do |x|
  puts "RestClient n = #{n}"
  x.report { n.times do   ; RestClient.get('http://localhost:4567/') end }
  puts "HttpMini n = #{n}"
  x.report { n.times do   ; HttpMini.new('http://localhost:4567/').get end }
  puts "raw URI + Net::HTTP n = #{n}"
  x.report { n.times do   ; raw_http('http://localhost:4567/') end }
end