# encoding: utf-8
require 'mining_depot/entity'

class Depot < MiningDepot::Entity
  attr_accessor :capacity, :semaphore, :loads

  def initialize(options = {})
    @semaphore = Mutex.new
    @capacity  = options[:capacity]
    @loads     = Hash.new(0)
  end

  def receive_load(loads = {})
    return unless loads.any?
    semaphore.synchronize do
      loads.each do |product, amount|
        @loads[product] += amount
      end
    end
  end

  def available
    semaphore.synchronize do
      return capacity if loads.none?
      return [0, capacity - loads.values.reduce(&:+)].max
    end
  end
end
