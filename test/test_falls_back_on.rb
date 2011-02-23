require 'helper'

class Car1
  attr_accessor :fuel
  attr_accessor :random_number
  attr_accessor :some_place_in_the_mall
  falls_back_on :fuel => 'gasoline',
                :random_number => lambda { rand },
                :some_place_in_the_mall => lambda { some_place_in_the_mall }
  def self.some_place_in_the_mall
    "Orange Julius at #{Time.now}"
  end
end

class Car2 < ActiveRecord::Base
  set_table_name :cars2
  def self.create_table
    connection.create_table :cars2, :force => true do |t|
      t.string :fuel
      t.float :efficiency
      t.integer :popularity
    end
  end
  
  attr_accessor :efficiency2
  
  falls_back_on  :fuel => 'diesel',
                 :efficiency => lambda { calculate(:average, :efficiency) },
                 :efficiency2 => lambda { weighted_average(:efficiency, :weighted_by => :popularity ) }
end

Car2.create_table
Car2.create! :efficiency => 10.0, :popularity => 1_000_000
Car2.create! :efficiency => 1.0, :popularity => 1

class Car3
  attr_accessor :long_running_calculation
  falls_back_on :long_running_calculation => lambda { sleep 3 }
end

class TestFallsBackOn < Test::Unit::TestCase
  def test_fallback
    assert_equal 'gasoline', Car1.fallback.fuel
  end
  
  def test_active_record
    assert_equal 'diesel', Car2.fallback.fuel
  end
  
  def test_proc
    assert Car1.fallback.random_number.is_a?(Numeric)
  end
  
  def test_proc_calling_class_method
    assert(Car1.fallback.some_place_in_the_mall =~ /Orange Julius/)
  end
  
  def test_active_record_calculations
    assert_equal 5.5, Car2.fallback.efficiency
  end
  
  def test_weighted_average
    assert_equal 10, Car2.fallback.efficiency2.round
  end
  
  def test_cache
    random_number = Car1.fallback.random_number
    assert_equal random_number, Car1.fallback.random_number
    assert_equal random_number, Car1.fallback.random_number
  end
  
  def test_retries_if_lock
    blocker = Thread.new { Car3.fallback.long_running_calculation }

    assert_raises(::Timeout::Error) do
      ::Timeout.timeout(2) do
        Car3.fallback.long_running_calculation
      end
    end
    
    blocker.kill
  end
end
