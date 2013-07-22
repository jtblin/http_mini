# Http mini

A truly minimalist Http client for Ruby. When all you want is
a one liner to ping or get the response.

## Install

    gem install http_mini --no-ri --no-rdoc

## Usage

    response = HttpMini.new('http://www.google.com').head
    puts response.code

By default, HttpMini ignores errors and will return nil in case of error.
If you want to raise error, you can set the option on initialization.
You can also set values for timeouts.

    response = HttpMini.new('http://www.google.com', {ignore_error: false, open_timeout: 5}).get
    puts response.body

## Author

Jerome Touffe-Blin, [@jtblin](https://twitter.com/jtlbin), [http://www.linkedin.com/in/jtblin](http://www.linkedin.com/in/jtblin)

## License

HttpMini is copyright 2013 Jerome Touffe-Blin and contributors. It is licensed under the BSD license. See the include LICENSE file for details.

