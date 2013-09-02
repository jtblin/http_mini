require 'sinatra'

set :environment, ENV['RACK_ENV'].to_sym

get '/' do
  puts "GET request"
  response.write "GET request"
end

post '/' do
  puts "POST request"
  response.write "POST request"
end

put '/' do
  puts "PUT request"
  response.write "PUT request"
end

delete '/' do
  puts "DELETE request"
  response.write "DELETE request"
end

options '/' do
  puts "OPTIONS request"
  response.write "OPTIONS request"
end