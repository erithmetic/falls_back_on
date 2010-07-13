require 'falls_back_on/app/models/fallback'

ActiveRecord::Base.class_eval do
  extend FallsBackOn
end
