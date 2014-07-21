# encoding: utf-8

require 'mining_depot/entity'
require 'mining_depot/entities/mine'
require 'mining_depot/entities/truck'
require 'mining_depot/entities/depot'
require 'matrix'

class World < MiningDepot::Entity
  attribute :depots, Array[Depot]
  attribute :mines,  Array[Mine]
  attribute :trucks, Array[Truck]

  attribute :height, Integer, default: 100
  attribute :width,  Integer, default: 100

  def initialize(options = {})
    super(options)
    generate_locations!
  end

  def[](x, y)
    @locations[y, x]
  end

  private

  def generate_locations!
    @locations = Matrix.build(@height, @width) do |r, c|
      Location.new(x: c, y: r)
    end
  end
end
