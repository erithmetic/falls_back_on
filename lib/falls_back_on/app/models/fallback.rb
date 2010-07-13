class Fallback < ActiveRecord::Base
  index :name if respond_to? :index
  
  serialize :values
  
  class << self
    def get_for(name)
      klass = name.constantize
      if fallback = find_by_name(name)
        begin
          f = klass.new(fallback.values)
        rescue ActiveRecord::UnknownAttributeError
          raise $!, "while trying to use #{fallback.values.inspect} with #{name} #{$!.inspect}"
        end
        f.readonly!
        f
      elsif klass.set_fallback
        get_for(name)
      end
    end
    
    def set_for(name, values = {})
      raise "fallback race condition" if Fallback.count > 100
      fallback = find_or_create_by_name(name)
      fallback.update_attributes(:values => values)
      true
    end
    
    def destroy_for(name)
      find_by_name(name).andand.destroy
      true
    end
  end
end
