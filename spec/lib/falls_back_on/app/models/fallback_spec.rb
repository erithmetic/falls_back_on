require 'spec_helper'

class Arcade < ActiveRecord::Base
  attr_accessor :pinball_count, :video_game_count

  falls_back_on :pinball_count => 73
end

describe Fallback do
  describe '.destroy_for' do
    it 'should destroy a fallback' do
      Fallback.create :name => 'Arcade'
      expect do
        Fallback.destroy_for Arcade
      end.should change(Fallback, :count).by(-1)
    end
  end
end

