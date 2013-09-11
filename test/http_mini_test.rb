require 'minitest_helper'
require 'http_mini'
require 'uri'

class HttpMiniTest < Minitest::Test

  describe 'HttpMini' do
    before do
      @url = 'http://www.google.com'
    end

    it 'makes a GET request and returns the response' do
      stub_request(:get, "www.google.com").to_return(:body => "abc")
      assert_equal 'abc', HttpMini.new(@url).get.body
    end

    it 'makes a HEAD request and returns the status code' do
      stub_request(:head, "www.google.com").to_return(:status => 200)
      assert_equal '200', HttpMini.new(@url).head.code
    end

    it 'makes a POST request with data' do
      stub_request(:post, "www.google.com").with(:body => "abc")
      HttpMini.new(@url).post('abc')
    end

    it 'makes a PUT request with data' do
      stub_request(:put, "www.google.com").with(:body => "abc")
      HttpMini.new(@url).put('abc')
    end

    it 'makes a DELETE request' do
      stub_request(:delete, "www.google.com")
      HttpMini.new(@url).delete
    end

    it 'makes a OPTIONS request' do
      stub_request(:options, "www.google.com")
      HttpMini.new(@url).options
    end

    specify 'pokes returns true when the status of the HEAD request is 200' do
      stub_request(:head, "www.google.com").to_return(:status => 200)
      assert_equal true, HttpMini.new(@url).poke
    end

    specify 'pokes returns false when the status of the HEAD request is 404' do
      stub_request(:head, "www.google.com").to_return(:status => 404)
      assert_equal false, HttpMini.new(@url).poke
    end

    it 'sets the http headers from options hash' do
      stub_request(:get, "www.google.com").with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'user-agent' => 'Fancy UserAgent Name'}).to_return(:body => "abc")
      assert_equal 'abc', HttpMini.new(@url, headers: {'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent' => 'Fancy UserAgent Name'}).get.body
    end

    it 'uses the full path' do
      stub_request(:get, "www.acme.com/foo?bar=baz").to_return(:status => 200)
      HttpMini.new('http://www.acme.com/foo?bar=baz').get
    end

    it 'allows basic auth' do
      stub_request(:get, "foo:bar@www.acme.com/").to_return(:status => 200)
      HttpMini.new('http://foo:bar@www.acme.com/').get
    end

    describe 'uri' do

      it 'parses the uri' do
        http = HttpMini.new @url
        assert_equal 'www.google.com', http.host
        assert_equal '/', http.path
      end

      it 'parses the new uri' do
        http = HttpMini.new @url
        http.uri 'http://www.acme.com'
        assert_equal 'www.acme.com', http.host
      end

      it 'allows passing query string parameters' do
        http = HttpMini.new "#{@url}/?q=1"
        assert_equal 'q=1', http.uri.query
      end

      it 'returns the uri object' do
        http = HttpMini.new @url
        assert http.uri.kind_of?(URI::Generic), "Expected #{http.uri} to be of kind of URI::Generic"
      end

      it 'handles https' do
        http = HttpMini.new 'https://www.google.com'
        assert_equal 443, http.port
      end

      it 'handles missing scheme' do
        http = HttpMini.new 'www.google.com'
        assert_equal 'www.google.com', http.host
        assert_equal 80, http.port
      end

      describe "path"  do
        it 'uses the new path' do
          http = HttpMini.new @url
          http.path '/newpath'
          assert_equal '/newpath', http.path
        end

        it 'keeps the query string parameters' do
          http = HttpMini.new @url
          http.path '/newpath?q=1'
          assert_equal 'q=1', http.uri.query
        end
      end
    end
  end

end