# encoding: utf-8

class TruckLoop < Interactor
  required do
    model :truck
  end

  def execute
    l = truck.logger || Logger.new('/dev/null')
    # truck.destination = truck.next_destination if truck.destination.nil?

    next_loc = truck.next_location(truck.location)
    l.info "moving to #{next_loc.coordinates}"

    s = MoveTruck.run(
      truck: truck,
      location: truck.next_location(truck.location)
    )

    l.info "Moved: #{s.success?}"
  end
end
