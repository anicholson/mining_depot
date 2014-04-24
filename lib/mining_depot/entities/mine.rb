require 'mining_depot/entity'

class Mine < MiningDepot::Entity
  def initialize
    @state = :stopped
  end

  def status
    {
      state: @state
    }
  end

  def start
    @state = :started
  end
end
