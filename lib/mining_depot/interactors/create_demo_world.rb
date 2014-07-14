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
      height: world[:height]
    )
  end
end
