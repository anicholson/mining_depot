require 'mining_depot/entity'

class Mine < MiningDepot::Entity
  attr_accessor :semaphore, :logger, :start_trigger

  class Machinery < Thread
  end

  def initialize
    @state         = :stopped
    @machinery     = machine
    @semaphore     = Mutex.new
    @start_trigger = ConditionVariable.new
  end

  def status
    {
      state: @state
    }
  end

  def start
    return @state if @state == :started
    semaphore.synchronize { @state = :started }
    start_trigger.broadcast
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
