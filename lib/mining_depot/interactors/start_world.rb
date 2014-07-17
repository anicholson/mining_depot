require 'mining_depot/interactor'

class StartWorld < Interactor
  required do
    model :world
  end

  def execute
    world.logger.info 'Starting world...'
    world.mines.each  { |mine|  mine.start  }
    world.trucks.each { |truck| truck.start }
  end
end
