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
    World.new(
      width:  world[:width],
      height: world[:height],
      mines:  generate_mines
    ).tap do |w|
      place_buildings!(w, w.mines)
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

  def place_buildings!(w, mines)
    mines.each do |m|
      y = rand world[:height]
      x = rand world[:width]
      location = w[x, y]

      redo if location.building
      m.location        = location
      location.building = m
    end
  end
end
