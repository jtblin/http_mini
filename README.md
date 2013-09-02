# Http mini

[![Gem Version](https://badge.fury.io/rb/http_mini.png)](http://badge.fury.io/rb/http_mini)
[![Build Status](https://travis-ci.org/jtblin/http_mini.png)](https://travis-ci.org/jtblin/http_mini)
[![Coverage Status](https://coveralls.io/repos/jtblin/http_mini/badge.png?branch=master)](https://coveralls.io/r/jtblin/http_mini?branch=master)
[![Code Climate](https://codeclimate.com/github/jtblin/http_mini.png)](https://codeclimate.com/github/jtblin/http_mini)

A truly minimalist Http client for Ruby. When all you want is
a one liner to ping or get the response from a web server.

## Install

    gem install http_mini --no-ri --no-rdoc

## Usage

    # Sometimes you just need to know if the site is up and running
    do_something if HttpMini.new('http://www.acme.com').poke

    # or you want to get the status code
    puts HttpMini.new('http://www.google.com').head.code

    # You can also set values for timeouts.
    puts HttpMini.new('http://www.google.com', {read_timeout: 3, open_timeout: 5}).get.body

    #You can change the url and chain calls
    http = HttpMini.new('www.apple.com')
    apple_html = http.get.body
    ruby_html = http.uri('http://www.ruby-lang.org/en/').get.body

    # or just the path
    http_request_html = http.path('/stdlib-1.9.3/libdoc/net/http/rdoc/Net/HTTPRequest.html').get.body

    # Set http headers
    puts HttpMini.new('http://www.google.com', headers: {'user-agent' => 'Fancy UserAgent Name'}).head.code

## HTTP verbs Support

* HEAD
* GET
* POST
* PUT
* DELETE
* OPTIONS

## Request options

* `:headers` - http headers, defaults to {}
* `:open_timeout` - number of seconds to wait for the connection to open, defaults to 2
* `:read_timeout` - number of seconds to wait for one block to be read, defaults to 2

## Author

Jerome Touffe-Blin, [@jtblin](https://twitter.com/jtlbin), [http://www.linkedin.com/in/jtblin](http://www.linkedin.com/in/jtblin)

## License

HttpMini is copyright 2013 Jerome Touffe-Blin and contributors. It is licensed under the BSD license.
See the include LICENSE file for details.

