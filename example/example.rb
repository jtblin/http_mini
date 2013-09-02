# Usage
#    rake server
#    ruby example/example.rb
#

require 'http_mini'

http = HttpMini.new('localhost:4567')
puts http.get.body
puts http.post('data').body
puts http.head.code
puts http.poke
puts http.put('data').body
puts http.delete.body