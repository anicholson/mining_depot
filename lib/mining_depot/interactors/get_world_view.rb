# encoding: utf-8

require 'mining_depot/interactor'

class GetWorldView < Interactor
  class WorldView < OpenStruct
    def inspect
      "width: #{map.column_size} height: #{map.row_size} #{counts.inspect}"
    end
  end

  class CountView < OpenStruct
    def inspect
      "mines: #{mines} trucks: #{trucks} depots: #{depots}"
    end
  end

  optional do
    string :world_name
  end

  def execute
    WorldView.new(
      counts:     counts_for(world),
      dimensions: [world.width, world.height],
      map:        Matrix.build(world.height, world.width) do |r, c|
        square_at(r, c)
      end
    )
  end

  private

  def counts_for(world)
    CountView.new(
      mines:  world.mines.count,
      trucks: world.trucks.count,
      depots: world.depots.count
    )
  end

  def square_at(row, col)
    representation_of(world[col, row])
  end

  def representation_of(location)
    OpenStruct.new(
      mine:  location.mine?,
      depot: location.depot?,
      truck: location.truck?
    )
  end

  def world
    name = world_name || Universe::DEFAULT
    @world ||= Universe[name]
  end
end
