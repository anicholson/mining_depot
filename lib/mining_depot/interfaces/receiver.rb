require 'mining_depot'
module MiningDepot
  module Receiver
    def receive
      raise NotImplementedError
    end
  end
end
