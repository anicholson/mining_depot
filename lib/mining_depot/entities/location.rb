require 'mining_depot/entity'
require 'hashie'

class Location < MiningDepot::Entity
  attr_reader :coordinates

  def initialize(params = {})
    x = params[:x] || 0
    y = params[:y] || 0
    @coordinates = Hashie::Mash.new(x: x, y: y)
  end
end
