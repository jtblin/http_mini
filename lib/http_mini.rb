require 'net/http'
require "uri"

class HttpMini

  attr_reader :uri
  attr_accessor :opts

  OPEN_TIMEOUT = 2
  READ_TIMEOUT = 2
  IGNORE_ERROR = true

  def self.VERSION
    '0.1.0'
  end

  def initialize(url, opts = {})
    self.uri = url
    self.opts = opts
  end

  def head
    request { |http| http.head(path) }
  end

  def get
    request { |http| http.get(path) }
  end

  def post(data)
    request { |http| http.post(path, data) }
  end

  def put(data)
    request { |http| http.put(path, data) }
  end

  def delete
    request { |http| http.delete(path) }
  end

  def options
    request { |http| http.options(path) }
  end

  private

  def request
    begin
      Net::HTTP.start(host, port) {|http| set_timeout(http) and yield(http) }
    rescue Exception => e
      raise e unless ignore_error?
    end
  end

  def set_timeout(http)
    http.open_timeout, http.read_timeout = timeouts
  end

  def uri=(uri)
    @uri = URI.parse(uri)
  end

  def host
    uri.host
  end

  def port
    uri.port
  end

  def path
    uri.path.empty? ? '/' : uri.path
  end

  def timeouts
    [open_timeout, read_timeout]
  end

  def open_timeout
    opts[:open_timeout].nil? ? OPEN_TIMEOUT : opts[:open_timeout]
  end

  def read_timeout
    opts[:read_timeout].nil? ? READ_TIMEOUT : opts[:read_timeout]
  end

  def ignore_error?
    opts[:ignore_error].nil? ? IGNORE_ERROR : opts[:ignore_error]
  end

end