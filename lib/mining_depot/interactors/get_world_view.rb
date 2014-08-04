require 'mining_depot/interactor'

class GetWorldView < Interactor
  optional do
    string :world_name
  end

  def execute
    OpenStruct.new.tap do |v|
      v[:map]    = Matrix.build(world.height, world.width) { nil }
      v[:counts] = counts_for(world)
    end
  end

  private

  def counts_for(world)
    OpenStruct.new.tap do |c|
      c.mines  = world.mines.count
      c.trucks = 0
      c.depots = world.depots.count
    end
  end

  def world
    name = world_name || Universe::DEFAULT
    @world ||= Universe[name]
  end
end
