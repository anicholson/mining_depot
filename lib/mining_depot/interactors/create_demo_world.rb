# encoding: utf-8

require 'mining_depot/interactor'

class CreateDemoWorld < Interactor
  required do
    hash :world do
      integer :width,  min: 20
      integer :height, min: 20
    end
  end

  def execute
    Universe[Universe::DEFAULT] = World.new(
      width:  world[:width],
      height: world[:height],
      mines:  generate_mines,
      depots: generate_depots
    ).tap do |w|
      place_buildings!(w, w.mines)
      place_buildings!(w, w.depots)
    end
  end

  private

  def generate_mines
    speeds   = (1..10).to_a
    minerals = [:silver, :gold, :copper]

    (1..10).map do
      Mine.new(
        speed: speeds.sample,
        minerals: minerals.sample
      )
    end
  end

  def generate_depots
    (1..5).map { Depot.new(capacity: 2000) }
  end

  def place_buildings!(w, buildings)
    buildings.each do |b|
      y = rand world[:height]
      x = rand world[:width]
      location = w[x, y]

      redo if location.building
      b.location        = location
      location.building = b
    end
  end
end
