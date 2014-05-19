require 'mining_depot/entity'
require 'hashie'

class Location < MiningDepot::Entity
  attr_reader :coordinates, :name

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
end
