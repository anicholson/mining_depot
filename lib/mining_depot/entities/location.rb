# encoding: utf-8
require 'mining_depot/entity'
require 'hashie'

class Location < MiningDepot::Entity
  class NullBuilding; end

  attribute :building,    MiningDepot::Entity,     default: NullBuilding.new
  attribute :name,        String,                  writer: :private
  attribute :coordinates, Hash[Symbol => Integer], writer: :private
  attribute :world

  def initialize(params = {})
    x     = params[:x] || 0
    y     = params[:y] || 0
    @name = params[:name]
    @coordinates = Hashie::Mash.new(x: x, y: y)
  end

  def ==(other)
    other.is_a?(Location) && (coordinates == other.coordinates)
  end

  def name
    name = @name || 'Location'
    "#{name} (#{coordinates.x}, #{coordinates.y})"
  end

  def mine?
    building.is_a?(Mine)
  end

  def depot?
    building.is_a?(Depot)
  end

  def truck?
    world.trucks_at(self).any?
  end
end
