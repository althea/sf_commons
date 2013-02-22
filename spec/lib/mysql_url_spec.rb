require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MysqlURI do
  it "parses simple urls" do
    uri = MysqlURI.new('mysql://localhost')
    options = uri.to_options
    options[:host].should == 'localhost'
    options[:port].should == 3306
  end

  it "raises error on a different adapter" do
    begin
      uri = MysqlURI.new('pg://localhost')
      fail "Expected an error as the protocol is not supposed to be parsed"
    rescue
    end
  end

  it "defaults port to 3306 and allows mysq2" do
    uri = MysqlURI.new('mysql2://localhost')
    options = uri.to_options
    options[:host].should == 'localhost'
    options[:port].should == 3306
  end
  
  it "defaults standard things like poolsize and verify connection" do
    uri = MysqlURI.new('mysql://localhost')
    options = uri.to_options
    options[:host].should == 'localhost'
    options[:port].should == 3306
    options[:pool].should == 25
    options[:encoding].should == 'utf8'
    options[:adapter].should == 'mysql2'
    options[:verify_connection].should == true
  end
  
  it "uses correct database" do
    uri = MysqlURI.new('mysql2://localhost:4009/foobar')
    options = uri.to_options
    options[:host].should == 'localhost'
    options[:port].should == 4009
    options[:database].should == 'foobar'
    
  end
  # 
  it "uses correct username/password" do
    uri = MysqlURI.new('mysql2://foo:bar@localhost/9')
    options = uri.to_options
    options[:host].should == 'localhost'
    options[:password].should == 'bar'
  end
  
  it "uses correct timeout" do
    uri = MysqlURI.new('mysql2://localhost/foobar?timeout=3')
    options = uri.to_options
    options[:timeout].should == 3
  end

  it "uses correct connection poolsize" do
    uri = MysqlURI.new('mysql2://localhost/foobar?timeout=3&pool=5')
    options = uri.to_options
    options[:pool].should == 5
  end
end