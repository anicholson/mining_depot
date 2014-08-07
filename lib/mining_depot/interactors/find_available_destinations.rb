# encoding: utf-8

require 'mining_depot/interactor'

class FindAvailableDestinations < Interactor
  required do
    model :world
    model :truck
  end

  def execute
    if truck.empty?
      world.mines.select { |m| m.available? }
    else
      world.depots.select { |d| d.can_accept? truck }
    end
  end
end
