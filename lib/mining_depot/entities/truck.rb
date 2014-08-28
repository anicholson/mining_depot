# encoding: utf-8

require 'mining_depot/entity'
require 'mining_depot/entities/location'
require 'mining_depot/interactors/truck_loop'

class Truck < MiningDepot::Entity
  attribute :capacity,    Integer, default: 10
  attribute :location,    Location
  attribute :destination, Location, writer: :private
  attribute :load,        Hash[Symbol => Integer], writer: :private
  attribute :behaviour,   Object, default: ::TruckLoop

  def initialize(*args)
    super(*args)
    @semaphore = Mutex.new
  end

  def start
    Thread.new(self) do |truck|
      l = truck.logger
      l.info 'Starting Truck.'

      loop { truck.behaviour.run(truck: truck) }
    end
  end

  def move_to(location)
    semaphore.synchronize { @location = location }
  end

  def location
    semaphore.synchronize { @location }
  end

  def next_destination
  end

  def navigation
  end

  protected

  attr_accessor :semaphore
end
