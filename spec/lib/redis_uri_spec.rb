require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RedisURI do
  it "parses simple urls" do
    uri = RedisURI.new('redis://localhost:6379')
    options = uri.to_options
    options[:host].should == 'localhost'
    options[:port].should == 6379
  end

  it "defaults port to 6379" do
    uri = RedisURI.new('redis://localhost')
    options = uri.to_options
    options[:host].should == 'localhost'
    options[:port].should == 6379
  end

  it "defaults port to 6379" do
    uri = RedisURI.new('redis://localhost')
    options = uri.to_options
    options[:host].should == 'localhost'
    options[:port].should == 6379
  end

  it "defaults db to 0" do
    uri = RedisURI.new('redis://localhost')
    options = uri.to_options
    options[:host].should == 'localhost'
    options[:port].should == 6379
    options[:db].should == 0
  end

  it "uses correct database" do
    uri = RedisURI.new('redis://localhost/9')
    options = uri.to_options
    options[:host].should == 'localhost'
    options[:port].should == 6379
    options[:db].should == 9
  end

  it "uses correct password" do
    uri = RedisURI.new('redis://foo:bar@localhost/9')
    options = uri.to_options
    options[:host].should == 'localhost'
    options[:password].should == 'bar'
  end

  it "uses correct timeout" do
    uri = RedisURI.new('redis://localhost/9?timeout=3')
    options = uri.to_options
    options[:timeout].should == 3
  end

  it "ensures protocol is redis" do
    begin
      uri = RedisURI.new('foo://localhost')
      fail
    rescue
    end
  end
end