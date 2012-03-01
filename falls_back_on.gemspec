# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "falls_back_on/version"

Gem::Specification.new do |s|
  s.name        = "falls_back_on"
  s.version     = FallsBackOn::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Seamus Abshere', 'Derek Kastner']
  s.email       = ["seamus@abshere.net"]
  s.homepage    = 'http://github.com/dkastner/falls_back_on'
  s.summary     = 'Adds ActiveRecord::Base.falls_back_on and ActiveRecord::Base.fallback'
  s.description = 'ActiveRecord extension to intelligently fall back on another column when a given column is unavailable'

  s.rubyforge_project = "falls_back_on"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency 'cache_method', '>=0.2.0'
  s.add_dependency 'lock_method', '>=0.4.0'
  s.add_development_dependency 'test-unit'
  s.add_development_dependency 'memcached'
  s.add_development_dependency 'activerecord'
  s.add_development_dependency 'sqlite3-ruby'
  s.add_development_dependency 'weighted_average'
  if RUBY_VERSION >= '1.9'
    s.add_development_dependency 'ruby-debug19'
  else
    s.add_development_dependency 'ruby-debug'
  end
end
