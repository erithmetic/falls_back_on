require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:runtime, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
cwd = File.dirname(__FILE__)

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.version = '0.0.1'
  gem.name = "falls_back_on"
  gem.summary = 'ActiveRecord extension to intelligently fall back on another column when a given column is unavailable'
  gem.description = File.read(File.join(cwd, 'README.rdoc'))
  gem.email = 'seamus@brighterplanet.com'
  gem.homepage = 'http://github.com/brighterplanet/falls_back_on'
  gem.authors = %w{Seamus Abshere Derek Kastner}

  gem.files = Dir.glob(File.join(cwd, 'lib', '**/*.rb')) + ['init.rb'] +
    Dir.glob(File.join(cwd, 'rails', '**/*.rb'))

  gem.add_dependency 'activerecord'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'jeweler'
  gem.add_development_dependency 'bundler'
end
Jeweler::GemcutterTasks.new


require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "falls_back_on #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
