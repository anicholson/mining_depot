# encoding: utf-8
require 'mining_depot/entity'
require 'logger'

class Truck < MiningDepot::Entity
  include MiningDepot::Receiver

  attribute :capacity, Integer, default: 10

  def receive(_product, _amount)
    true
  end
end
