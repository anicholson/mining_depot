# encoding: utf-8
require 'mining_depot/entity'
require 'mining_depot/interfaces/receiver'

class Sink < MiningDepot::Entity
  include MiningDepot::Receiver
end
