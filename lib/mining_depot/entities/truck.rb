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
    Thread.new(self) do |truck|
      l = truck.logger
      l.info 'Starting Truck.'
      loop do
        # truck.destination = truck.next_destination if truck.destination.nil?

        next_loc = truck.next_location(truck.location)
        l.info "moving to #{next_loc.coordinates}"

        s = MoveTruck.run(
          truck: truck,
          location: truck.next_location(truck.location)
        )

        l.info "Moved: #{s.success?}"

        time = s.success? ? 0.5 : 0.3
        l.info "Sleeping: #{time}"
        sleep time
      end
    end
  end

  def move_to(location)
    semaphore.synchronize do
      @location = location
    end
  end

  def location
    semaphore.synchronize { @location }
  end

  def next_destination

  end

  def next_location(current)
    c = current.coordinates
    x, y = c[:x], c[:y]

    change = [1,-1].sample

    if n = rand(4).even?
      current.world[x+change,y]
    else
      current.world[x, y+change]
    end
  end

  protected

  attr_accessor :semaphore
end
