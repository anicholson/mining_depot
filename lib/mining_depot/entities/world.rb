require 'mining_depot/entity'
require 'mining_depot/entities/mine'
require 'mining_depot/entities/truck'
require 'mining_depot/entities/depot'

class World < MiningDepot::Entity
  attribute :depots, Array[Depot]
  attribute :mines,  Array[Mine]
  attribute :trucks, Array[Truck]
end
