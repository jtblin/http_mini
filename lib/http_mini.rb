require 'net/http'
require "uri"

class HttpMini

  attr_accessor :opts

  IGNORE_ERROR = true

  def self.VERSION
    '0.3.2'
  end

  def initialize(uri, opts = {})
    self.uri = uri
    self.opts = opts
  end

  def head
    request Net::HTTP::Head.new(full_path, headers)
  end

  def get
    request Net::HTTP::Get.new(full_path, headers)
  end

  def post(data)
    request Net::HTTP::Post.new(full_path, headers), data
  end

  def put(data)
    request Net::HTTP::Put.new(full_path, headers), data
  end

  def delete
    request Net::HTTP::Delete.new(full_path, headers)
  end

  def options
    request Net::HTTP::Options.new(full_path, headers)
  end

  def poke
    begin
      opts[:unsafe] = opts[:unsafe] != false
      success? head
    rescue Exception => e
      raise e unless ignore_error?
      false
    end
  end
  alias_method :ping, :poke

  def uri(uri=nil)
    uri.nil? ? @uri : ((self.uri = uri) and self)
  end

  def host
    @uri.host
  end

  def port
    @uri.port
  end

  def path(path=nil)
    path.nil? ? @uri.request_uri : set_path(path)
  end

  private

  def uri=(uri)
    @uri = URI.parse(handle_missing_scheme(uri)) unless uri.nil? || uri.empty?
  end

  def handle_missing_scheme(uri)
    uri[0..3] == 'http' ? uri : "http://#{uri}"
  end

  def request(req, data=nil)
    http.start { |http| http.request(auth(req), data) }
  end

  def http
    http = Net::HTTP.new(@uri.host, @uri.port)
    http.use_ssl = @uri.instance_of?(URI::HTTPS)
    # TODO: add test
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE if http.use_ssl? && opts[:unsafe] == true
    http.open_timeout = http.read_timeout = opts[:timeout] if opts.key? :timeout
    http
  end

  def auth(req)
    req.basic_auth(@uri.user, @uri.password) if @uri.user
    req
  end

  def headers
    opts[:headers] || {}
  end

  def full_path
    @uri.request_uri
  end

  def set_path(path)
    @uri.path = path.match(/\?/) ? handle_query(path) : path
    self
  end

  def handle_query(path)
    uri.query = path.gsub /.*\?/, ''
    path.gsub /\?.*/, ''
  end

  def ignore_error?
    opts[:ignore_error].nil? ? IGNORE_ERROR : opts[:ignore_error]
  end

  def success?(response)
    response && response.code.to_i >= 200 && response.code.to_i < 400
  end

end