source "http://rubygems.org"

# Specify your gem's dependencies in falls_back_on.gemspec
gemspec

if ENV['RUBY_DEBUG']
  if RUBY_VERSION >= '1.9'
    s.add_development_dependency 'ruby-debug19'
  else
    s.add_development_dependency 'ruby-debug'
  end
end
