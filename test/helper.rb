require 'rubygems'
require 'bundler'
Bundler.setup
require 'test/unit'
require 'active_record'
require 'active_support/all'
require 'weighted_average'
require 'memcached'
require 'timeout'
require 'ruby-debug'
$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'falls_back_on'

# thanks authlogic!
ActiveRecord::Schema.verbose = false
begin
  ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
rescue ArgumentError
  ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :dbfile => ":memory:")
end

my_client = Memcached.new
CacheMethod.config.storage = my_client
LockMethod.config.storage = my_client

class Test::Unit::TestCase
  def setup
    CacheMethod.config.storage.flush
    LockMethod.config.storage.flush
    @old_abort_on_exception = Thread.abort_on_exception
    Thread.abort_on_exception = true
  end
  
  def teardown
    Thread.abort_on_exception = @old_abort_on_exception
  end
end

ENV['FALLS_BACK_ON_DEBUG'] = 'true'
