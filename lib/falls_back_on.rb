module FallsBackOn
  def falls_back_on(options = {})
    class_eval do
      class_inheritable_accessor :fallback_options
    end
    self.fallback_options = options
    extend FallsBackOn::InstanceMethods
  end

  module InstanceMethods
    def class_name
      self.to_s
    end

    def fallback
      Fallback.get_for(class_name)
    end
    
    def fallback_value_for(k)
      v = fallback_options[k]
      case v
      when :random
        fallback_value_for_random(k)
      when Numeric
        v
      when String
        v.upcase.starts_with?('SELECT') ? ActiveRecord::Base.connection.select_value(v) : v
      when Proc
        v.call
      end
    end
    
    def fallback_value_for_name
      { :name => "Fallback #{class_name.underscore.gsub('_', ' ')}" }
    end
    
    def fallback_value_for_random(k)
      random = rand(1e8)
      return fallback_value_for_random(k) unless send("find_by_#{k}", random).nil?
      random
    end

    def destroy_fallback
      Fallback.destroy_for(class_name)
    end

    def set_fallback
      values = {}
      values = values.merge(fallback_value_for_name) if column_names.include?('name')
      values = fallback_options.keys.inject({}) { |memo, k| memo.merge(k => fallback_value_for(k)) }
      Fallback.set_for(class_name, values)
    end
  end
end
