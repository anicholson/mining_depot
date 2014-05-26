# encoding: utf-8
require 'mining_depot/entity'

class Depot < MiningDepot::Entity
  attr_accessor :capacity, :semaphore

  def initialize(options = {})
    @semaphore = Mutex.new
  end
end
