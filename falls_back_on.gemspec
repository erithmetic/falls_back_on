Gem::Specification.new do |gem|
  gem.name = "falls_back_on"
  gem.summary = %Q{ActiveRecord extension to intelligently fall back on another column when a given column is unavailable}
  gem.description = %Q{A DSL is available to tell ActiveRecord to use one column in leiu of another when a column has no data. Used in Brighter Planet's Carbon Middleware}
  gem.email = "seamus@brighterplanet.com"
  gem.homepage = "http://github.com/brighterplanet/falls_back_on"
  gem.authors = ["Seamus Abshere"]

  gem.add_runtime_dependency 'activerecord'
end
