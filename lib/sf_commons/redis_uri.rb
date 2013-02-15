class RedisURI
  def initialize(uri)
    @uri = Addressable::URI.parse(uri)
    raise "Are you sure this is a redis server" if @uri.scheme != 'redis'
  end

  def to_options
    {host: @uri.host, port: @uri.port|| 6379}.tap do |x|
      x[:password]= @uri.password if @uri.password
      x[:db] = @uri.path.gsub('/','').to_i if @uri.path
      x[:timeout] = @uri.query_values['timeout'].to_i if @uri.query_values &&  @uri.query_values.key?('timeout')
    end
  end
end