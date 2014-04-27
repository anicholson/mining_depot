require 'mining_depot/entity'

class Mine < MiningDepot::Entity
  attr_accessor :semaphore

  class Machinery < Thread

  end

  def initialize
    @state     = :stopped
    @machinery = machine
    @semaphore = Mutex.new
  end

  def status
    {
      state: @state
    }
  end

  def start
    semaphore.synchronize { @state = :started }
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
