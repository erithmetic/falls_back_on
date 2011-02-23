module FallsBackOn
  class Definition
    autoload :Storage, 'falls_back_on/definition/storage'
    
    def self.all
      Storage.instance.keys.map { |parent| new parent }
    end
    
    attr_reader :parent
    
    def initialize(parent)
      @parent = parent.to_s
    end
    
    def clear
      clear_method_cache :calculate
      clear_method_cache :attrs
      clear_lock :attrs
    end
    
    def attrs=(attrs)
      Storage.instance[parent] = attrs
    end
    
    def attrs
      Storage.instance[parent].inject({}) do |memo, (k, v)|
        memo[k] = calculate k
        memo
      end
    end
    lock_method :attrs
    cache_method :attrs
        
    def calculate(k)
      v = Storage.instance[parent][k]
      case v
      when Proc
        v.call
      else
        v
      end
    end
    cache_method :calculate
    
    # for cache_method and lock_method
    def hash
      parent.hash
    end
  end
end
