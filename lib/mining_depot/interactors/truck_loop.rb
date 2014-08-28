# encoding: utf-8

class TruckLoop < Interactor
  SUCCESS_TIMER = 0.5
  FAILURE_TIMER = 0.3

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

    s.success? ? sleep(SUCCESS_TIMER) : sleep(FAILURE_TIMER)
  end
end
