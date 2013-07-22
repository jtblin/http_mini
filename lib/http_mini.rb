require 'net/http'
require "uri"

class HttpMini

  attr_reader :uri
  attr_accessor :opts

  OPEN_TIMEOUT = 2
  READ_TIMEOUT = 2
  IGNORE_ERROR = true

  def self.VERSION
    '0.1.1'
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

  def ping
    success? head
  end

  private

  def request
    begin
      Net::HTTP.start(host, port, :use_ssl => ssl?) {|http| set_timeout(http) and yield(http) }
    rescue Exception => e
      raise e unless ignore_error?
    end
  end

  def ssl?
    uri.scheme == 'https'
  end

  def set_timeout(http)
    http.open_timeout, http.read_timeout = timeouts
  end

  def host
    uri.host || uri.path.split('/').first
  end

  def port
    uri.port
  end

  def path
    root? uri.path.gsub(Regexp.new('^' + host), '')
  end

  def root?(path)
    path.empty? ? '/' : path
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

  def success?(response)
    response && response.code.to_i >= 200 && response.code.to_i < 300 ? true : false
  end

end