class MysqlURI
  def initialize(uri)
    @uri = Addressable::URI.parse(uri)
    if @uri.scheme != 'mysql2' && @uri.scheme != 'mysql' && @uri.scheme != 'socket'
      raise "Are you sure this is a mysql server, mysql2 and socket schemes are supported"
    end
  end

  def to_options
    defaults = {pool: 25, adapter: 'mysql2',  encoding: 'utf8',  reconnect: true, verify_connection: true}
    if @uri.scheme == 'socket'
      defaults.merge(socket: @uri.path, database: @uri.query_values['database'])
    else
      defaults.merge(host: @uri.host, port: @uri.port|| 3306).tap do |x|
        x[:username]= @uri.user if @uri.user
        x[:password]= @uri.password if @uri.password
        x[:db] = x[:database] = @uri.path.gsub('/','') if @uri.path
        x[:timeout] = @uri.query_values['timeout'].to_i if @uri.query_values &&  @uri.query_values.key?('timeout')
        x[:pool] = @uri.query_values['pool'].to_i if @uri.query_values &&  @uri.query_values.key?('pool')
      end
    end
  end
end