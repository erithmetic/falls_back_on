module FallsBackOn
  class Definition
    autoload :Storage, 'falls_back_on/definition/storage'
    
    attr_reader :parent
    
    def initialize(parent)
      @parent = parent
    end
    
    def attrs=(attrs)
      Storage.instance[parent] = attrs
    end
    
    def attrs
      Storage.instance[parent].inject({}) do |memo, (k, v)|
        memo[k] = case v
        when Proc
          v.call
        else
          v
        end
        memo
      end
    end
  end
end
