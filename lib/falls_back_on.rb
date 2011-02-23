require 'cache_method'
require 'lock_method'

require 'falls_back_on/version'

module FallsBackOn
  autoload :Definition, 'falls_back_on/definition'

  def self.clear
    ::FallsBackOn::Definition.all.each { |definition| definition.clear }
  end
  
  def falls_back_on(attrs)
    definition = ::FallsBackOn::Definition.new self
    definition.attrs = attrs
  end
  
  def fallback
    obj = new
    definition = ::FallsBackOn::Definition.new self
    begin
      definition.attrs.each do |k, v|
        obj.send "#{k}=", v
      end
    rescue ::LockMethod::Locked
      $stderr.puts "#{self.to_s} was locked, retrying in 0.5 seconds..."
      sleep 0.5
      retry
    end
    obj
  end
end

unless ::Class.method_defined?(:falls_back_on)
  ::Class.send :include, ::FallsBackOn
end
