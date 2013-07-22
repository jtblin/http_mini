# Http mini

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

## HTTP verbs Support

* HEAD
* GET
* POST
* UPDATE
* DELETE
* OPTIONS

## Author

Jerome Touffe-Blin, [@jtblin](https://twitter.com/jtlbin), [http://www.linkedin.com/in/jtblin](http://www.linkedin.com/in/jtblin)

## License

HttpMini is copyright 2013 Jerome Touffe-Blin and contributors. It is licensed under the BSD license. See the include LICENSE file for details.

