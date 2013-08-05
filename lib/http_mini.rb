require 'net/http'
require "uri"

class HttpMini

  attr_accessor :opts

  OPEN_TIMEOUT = 2
  READ_TIMEOUT = 2
  IGNORE_ERROR = true

  def self.VERSION
    '0.2.1'
  end

  def initialize(url, opts = {})
    self.uri = url
    self.opts = opts
  end

  def head
    request { |http| http.head(full_path) }
  end

  def get
    request { |http| http.get(full_path) }
  end

  def post(data)
    request { |http| http.post(full_path, data) }
  end

  def put(data)
    request { |http| http.put(full_path, data) }
  end

  def delete
    request { |http| http.delete(full_path) }
  end

  def options
    request { |http| http.options(full_path) }
  end

  def poke
    begin
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
    @uri.host || @uri.path.split('/').first
  end

  def port
    @uri.port
  end

  def path(path=nil)
    path.nil? ? clean_path(@uri.path) : set_path(path)
  end

  private

  def uri=(uri)
    @uri = URI.parse(handle_missing_scheme(uri)) unless uri.nil? || uri.empty?
  end

  def handle_missing_scheme(uri)
    uri.match(/https?:\/\//) ? uri : "http://#{uri}"
  end

  def request
    Net::HTTP.start(host, port, :use_ssl => ssl?) {|http| set_timeout(http) and yield(http) }
  end

  def ssl?
    @uri.scheme == 'https'
  end

  def set_timeout(http)
    http.open_timeout, http.read_timeout = timeouts
  end

  def full_path
    @uri.query ? path + '?' + @uri.query : path
  end

  def clean_path(path)
    default_path remove_host_from_path(path)
  end

  def default_path(path)
    path.to_s.empty? ? '/' : path
  end

  def remove_host_from_path(path)
    path.to_s.gsub Regexp.new('^' + host), ''
  end

  def set_path(path)
    @uri.path = path.match(/\?/) ? handle_query(path) : path
    self
  end

  def handle_query(path)
    uri.query = path.gsub /.*\?/, ''
    path.gsub /\?.*/, ''
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
    response && response.code.to_i >= 200 && response.code.to_i < 400
  end

end