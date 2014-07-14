# encoding: utf-8
require 'mining_depot/entity'

class Truck < MiningDepot::Entity
  attribute :capacity, Integer, default: 10

  attr_accessor :semaphore

  def initialize(*args)
    super(*args)
    @semaphore = Mutex.new
  end

  def start
  end
end
