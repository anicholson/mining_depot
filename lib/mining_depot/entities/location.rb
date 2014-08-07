# encoding: utf-8
require 'mining_depot/entity'
require 'hashie'

class Location < MiningDepot::Entity
  attribute :name,        String,                  writer: :private
  attribute :coordinates, Hash[Symbol => Integer], writer: :private
  attribute :building,    MiningDepot::Entity
  attribute :road,        Boolean,                 writer: :private
  attribute :world

  def initialize(params = {})
    x     = params[:x] || 0
    y     = params[:y] || 0
    @name = params[:name]
    @coordinates = Hashie::Mash.new(x: x, y: y)
  end

  def name
    name = @name || 'Location'
    "#{name} (#{coordinates.x}, #{coordinates.y})"
  end

  def road?
    building? || @road
  end

  def mine?
    building? && building.is_a?(Mine)
  end

  def depot?
    building? && building.is_a?(Depot)
  end

  def building?
    building
  end

  def truck?
    world.trucks_at(self).any?
  end
end
