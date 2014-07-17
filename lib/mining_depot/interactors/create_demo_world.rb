require 'mining_depot/interactor'

class CreateDemoWorld < Interactor
  required do
    hash :world do
      integer :width,  min: 20
      integer :height, min: 20
    end
  end

  def execute
    World.new(
      width:  world[:width],
      height: world[:height],
      mines:  mines
    )
  end

  private

  def mines
    speeds   = (1..10).to_a
    minerals = [:silver, :gold, :copper]

    (1..150).map do
      Mine.new(
        speed: speeds.sample,
        minerals: minerals.sample
      )
    end
  end
end
