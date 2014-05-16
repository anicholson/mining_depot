require 'mining_depot/entity'
require 'logger'

class Truck < MiningDepot::Entity
  attr_accessor :capacity

  def initialize(options = {})
    @capacity = options[:capacity] || 0
  end
end
