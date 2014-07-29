# encoding: utf-8

require 'mining_depot/entity'
require 'mining_depot/entities/location'

class Truck < MiningDepot::Entity
  attribute :capacity,    Integer, default: 10
  attribute :location,    Location
  attribute :destination, Location, writer: :private
  attribute :load,        Hash[Symbol => Integer], writer: :private

  SUCCESS_TIMER = 0.5
  FAILURE_TIMER = 0.3

  def initialize(*args)
    super(*args)
    @semaphore = Mutex.new
  end

  def start
    Thread.new(self) do |truck|
      l = truck.logger
      l.info 'Starting Truck.'
      loop do
        s    = TruckLoop.run(truck: truck)

        time = s.success? ? SUCCESS_TIMER : FAILURE_TIMER
        l.info "Sleeping: #{time}"
        sleep time
      end
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

  def next_location(current)
    c      = current.coordinates
    x, y   = c[:x], c[:y]
    change = [1, -1].sample

    if rand(4).even?
      current.world[x + change, y]
    else
      current.world[x, y + change]
    end
  end

  protected

  attr_accessor :semaphore
end
