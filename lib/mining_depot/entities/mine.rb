require 'mining_depot/entity'

class Mine < MiningDepot::Entity
  class Machinery < Thread

  end

  def initialize
    @state     = :stopped
    @machinery = machine
  end

  def status
    {
      state: @state
    }
  end

  def start
    @state = :started
    @machinery.run
    @state
  end

  def product
    :gold
  end

  private

  def machine
    Machinery.new(self) do |mine|
      while mine.status[:state] == :started
        sleep 2
        puts 'mining'
      end
    end
  end

end
