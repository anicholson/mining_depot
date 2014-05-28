# encoding: utf-8
require 'mining_depot/entity'
require 'logger'

class Truck < MiningDepot::Entity
  attribute :capacity, Integer, default: 10
end
