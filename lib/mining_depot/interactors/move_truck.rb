# encoding utf-8

require 'mining_depot/interactor'

class MoveTruck < Interactor
  required do
    model :truck,    new_records: true
    model :location, new_records: true
  end

  def execute
    unless adjacent?(truck.location.coordinates, location.coordinates)
      add_error(:location, :invalid_destination)
      return false
    end

    true # TODO: actually move truck
  end

  def adjacent?(l1, l2)
    x_dist = (l1.x - l2.x).abs
    y_dist = (l1.y - l2.y).abs

    close_enough = !(x_dist >  1 || y_dist >  1) # too far
    not_diagonal = !(x_dist == 1 && y_dist == 1) # diagonal
    not_same     = !(x_dist == 0 && y_dist == 0) # same location

    not_same && close_enough && not_diagonal
  end
end
