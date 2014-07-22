require 'mining_depot/entities/location'
require 'mining_depot/interactor'

class FindNextLocation < Interactor
  required do
    model :truck
    model :world
  end

  def execute
    current_location = truck.location

    add_error(:truck, :location) unless current_location.world == world
  end
end
