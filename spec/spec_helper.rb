require 'rubygems'
require 'bundler'
begin
  Bundler.setup
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'active_record'
require 'logger'

$:.unshift File.expand_path('../lib', __FILE__)
require 'falls_back_on'
require 'falls_back_on/active_record_ext'
require 'falls_back_on/app/models/fallback'

ActiveRecord::Base.logger = Logger.new nil
ActiveRecord::Base.establish_connection :adapter => 'sqlite3', :database => ':memory:'

ActiveRecord::Schema.define(:version => 1) do
  create_table "fallbacks", :force => true do |t|
    t.string   "name"
    t.text     "values"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table 'states' do |t|
    t.integer 'area'
  end
end
