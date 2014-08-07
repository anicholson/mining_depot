# encoding: utf-8

require 'mining_depot/entity'
require 'mining_depot/entities/mine'
require 'mining_depot/entities/truck'
require 'mining_depot/entities/depot'
require 'matrix'

require 'digest/sha1'

class World < MiningDepot::Entity
  attribute :depots, Array[Depot]
  attribute :mines,  Array[Mine]
  attribute :trucks, Array[Truck]

  attribute :height, Integer, default: 100
  attribute :width,  Integer, default: 100

  def initialize(options = {})
    super(options)
    generate_id!
    generate_locations!
  end

  def[](x, y)
    @locations[y, x]
  end

  def ==(other)
    return false unless other.is_a? World

    id == other.id
  end

  def trucks_at(location)
    trucks.select { |t| t.coordinates == location.coordinates }
  end

  private

  attr_reader :id

  def generate_locations!
    world = self
    @locations = Matrix.build(@height, @width) do |r, c|
      Location.new(x: c, y: r).tap { |l| l.world = world }
    end
  end

  def generate_id!
    @id = Random.new.rand(1_000_000_000)
  end
end
