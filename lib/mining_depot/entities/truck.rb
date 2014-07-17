# encoding: utf-8
require 'mining_depot/entity'
require 'mining_depot/entities/location'

class Truck < MiningDepot::Entity
  attribute :capacity, Integer, default: 10
  attribute :location, Location

  attr_accessor :semaphore

  def initialize(*args)
    super(*args)
    @semaphore = Mutex.new
  end

  def start
  end

  def move_to(location)
    semaphore.synchronize do
      @location = location
    end
  end
end
