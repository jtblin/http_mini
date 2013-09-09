require 'sinatra'

get '/' do
  response.write "GET request"
end

post '/' do
  response.write "POST request"
end

put '/' do
  response.write "PUT request"
end

delete '/' do
  response.write "DELETE request"
end

options '/' do
  response.write "OPTIONS request"
end