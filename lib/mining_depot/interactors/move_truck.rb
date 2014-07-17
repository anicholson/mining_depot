# encoding utf-8

require 'mining_depot/interactor'

class MoveTruck < Interactor
  required do
    model :truck,    new_records: true
    model :location, new_records: true
  end

  optional { model :system }

  def execute
    catch :precondition_failure do
      guard_against(:location, :invalid_destination) do
        adjacent?(truck.location.coordinates, location.coordinates)
      end

      guard_against(:location, :unable_to_move) { truck.move_to(location) }
    end
  end

  def adjacent?(l1, l2)
    x_dist = (l1.x - l2.x).abs
    y_dist = (l1.y - l2.y).abs

    close_enough = !(x_dist >  1 || y_dist >  1) # too far
    not_diagonal = !(x_dist == 1 && y_dist == 1) # diagonal
    not_same     = !(x_dist == 0 && y_dist == 0) # same location

    not_same && close_enough && not_diagonal
  end

  def guard_against(input, error_code, &block)
    unless block && block.call
      add_error(input, error_code)
      throw :precondition_failure
    end
    true
  rescue => e
    add_error(:system, :error, e.message)
    throw :precondition_failure
  end
end
