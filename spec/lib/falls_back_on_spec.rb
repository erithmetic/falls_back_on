require 'spec_helper'

class State < ActiveRecord::Base
  falls_back_on :area => 10000
end

describe FallsBackOn do
  describe '.class_name' do
    it 'should return the class name' do
      State.class_name.should == 'State'
    end
  end

  describe '.set_fallback' do
    it 'should create a Fallback for a class' do
      State.set_fallback

      fallback = Fallback.find_by_name 'State'
      fallback.should be_an_instance_of(Fallback)
      fallback.values.should == {:area => 10000 }
    end
  end
end

