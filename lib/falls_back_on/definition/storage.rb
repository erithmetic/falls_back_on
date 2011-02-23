require 'singleton'
module FallsBackOn
  class Definition
    class Storage < ::Hash
      include ::Singleton
    end
  end
end
