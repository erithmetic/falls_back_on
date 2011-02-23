require 'cache_method'
require 'lock_method'

require 'falls_back_on/version'

module FallsBackOn
  autoload :Definition, 'falls_back_on/definition'

  def falls_back_on(attrs)
    definition = ::FallsBackOn::Definition.new self.to_s
    definition.attrs = attrs
  end
  
  def fallback
    obj = new
    definition = ::FallsBackOn::Definition.new self.to_s
    definition.attrs.each do |k, v|
      obj.send "#{k}=", v
    end
    obj
  end
end

unless ::Class.method_defined?(:falls_back_on)
  ::Class.send :include, ::FallsBackOn
end
