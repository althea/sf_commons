class CassandraURI
  def initialize(uri)
    @uri = Addressable::URI.parse(uri)
    raise "Are you sure this is a cassandra server" if @uri.scheme != 'cassandra'
    @options = @uri.query_values || {}
    @poolsize = @options.delete("pool") || 25
  end

  def keyspace
    @uri.basename if @uri.basename
  end
  def pool_size
    @poolsize.to_i
  end
  def server
    @uri.authority
  end

  def to_options
    @options
  end
end