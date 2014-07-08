# encoding: utf-8
require 'mining_depot/entity'

class Truck < MiningDepot::Entity
  attribute :capacity, Integer, default: 10
end
