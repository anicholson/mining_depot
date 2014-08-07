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
    WorldView.new.tap do |v|
      v[:counts] = counts_for(world)
      v[:dimensions] = [world.width, world.height]
      v[:map]    = Matrix.build(world.height, world.width) do |r, c|
        square_at(r, c)
      end
    end
  end

  private

  def counts_for(world)
    CountView.new.tap do |c|
      c.mines  = world.mines.count
      c.trucks = 0
      c.depots = world.depots.count
    end
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
