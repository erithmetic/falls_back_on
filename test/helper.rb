require 'rubygems'
require 'bundler'
Bundler.setup
require 'test/unit'
require 'active_record'
require 'active_support/all'
require 'weighted_average'
require 'memcached'
$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'falls_back_on'
class Test::Unit::TestCase
end

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
