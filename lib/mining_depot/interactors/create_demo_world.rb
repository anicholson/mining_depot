# encoding: utf-8

require 'mining_depot/interactor'

class CreateDemoWorld < Interactor
  Universe = MiningDepot::Universe

  required do
    hash :world do
      integer :width,  min: 20
      integer :height, min: 20
    end
  end

  def execute
    Universe[Universe::DEFAULT] = generate_world.tap do |w|
      place_buildings!(w, w.mines)
      place_buildings!(w, w.depots)
      place_trucks!(w, w.trucks)
    end
  end

  private

  def generate_world
    World.new(
      width:  world[:width],
      height: world[:height],
      mines:  generate_mines,
      depots: generate_depots,
      trucks: generate_trucks
    )
  end

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
      location = random_location_within(w)

      redo if location.building
      b.location        = location
      location.building = b
    end
  end

  def place_trucks!(w, trucks)
    trucks.each do |t|
      location = random_location_within(w)

      redo if location.truck?

      t.move_to location
    end
  end

  def generate_trucks
    (1..5).map { Truck.new }
  end

  def random_location_within(world_entity)
    y = rand world_entity.height
    x = rand world_entity.width
    world_entity[x, y]
  end
end
