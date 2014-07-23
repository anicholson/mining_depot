# encoding: utf-8
require 'mining_depot/entity'
require 'mining_depot/entities/location'

class Depot < MiningDepot::Entity
  attribute :loads,     Hash[Symbol => Float], writer: :private
  attribute :capacity,  Integer,               default: 100
  attribute :location,  ::Location

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

  def can_accept?(truck)
    available >= truck.capacity
  end

  def available
    semaphore.synchronize do
      return capacity if loads.none?
      return [0, capacity - loads.values.reduce(&:+)].max
    end
  end
end
