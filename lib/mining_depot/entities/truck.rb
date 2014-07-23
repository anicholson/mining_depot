# encoding: utf-8

require 'mining_depot/entity'
require 'mining_depot/entities/location'

class Truck < MiningDepot::Entity
  attribute :capacity,    Integer, default: 10
  attribute :location,    Location
  attribute :destination, Location, writer: :private
  attribute :load,        Hash[Symbol => Integer], writer: :private

  def initialize(*args)
    super(*args)
    @semaphore = Mutex.new
  end

  def start
    Thread.new do
      loop do
        _destination = next_destination if _destination.nil?
        # TODO: Get next location and attempt to move to it
      end
    end
  end

  def move_to(location)
    semaphore.synchronize do
      @location = location
    end
  end

  protected

  attr_accessor :semaphore
end
