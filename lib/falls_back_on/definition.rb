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
      cache_method_clear :calculate
      cache_method_clear :attrs
      lock_method_clear :attrs
    end
    
    def attrs=(attrs)
      Storage.instance[parent] = attrs
    end
    
    def attrs
      return {} unless Storage.instance[parent].is_a?(::Hash)
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
    
    # for lock_method
    def as_lock
      parent
    end
    # for cache_method
    def as_cache_key
      parent
    end
  end
end
