# encoding: utf-8
require 'mining_depot/entity'
require 'logger'

class Mine < MiningDepot::Entity
  attr_accessor :semaphore, :logger, :trigger, :speed

  class Machinery < Thread
    attr_reader :error_logger

    def self.next_mine_number
      @id ||= 0
      @id +=  1
    end

    def initialize(mine)
      @error_logger = Logger.new('errors.log')
      @mine = mine
      super(mine)
    end

    def mine_state
      @mine.semaphore.synchronize { @mine.status[:state] }
    end
  end

  def initialize(options = {})
    @logger    = options[:logger] || MiningDepot::Entity.logger
    @state     = :stopped
    @semaphore = Mutex.new
    @trigger   = ConditionVariable.new
    @machinery = machine
    @minerals  = options[:minerals] || {}
    @speed     = options[:speed]    || 1
  end

  def status
    {
      state: @state,
      depot: depot_storage
    }
  end

  def start
    return @state if @state == :started
    semaphore.synchronize { @state = :started }
    trigger.broadcast
    @state
  end

  def stop
    return @state if @state == :stopped
    semaphore.synchronize { @state = :stopped }
    trigger.broadcast
    @state
  end

  def products
    [@minerals]
  end

  def depot_storage
    products.each_with_object({}) do |mineral, h|
      h[mineral] = 0
    end
  end

  private

  # rubocop:disable MethodLength
  def machine
    Machinery.new(self) do |m|
      begin
        mine_number = Machinery.next_mine_number
        loop do
          state = Thread.current.mine_state
          case state
          when :started
            m.logger.info "#{mine_number}: mining"
            sleep 2
          when :stopped
            m.semaphore.synchronize { m.trigger.wait(m.semaphore) }
          else
            m.logger.warn("#{mine_number}: Unknown mine state #{state}")
            sleep 2
          end
        end
      rescue => e
        Machinery.error_logger.warn(e.message)
        Machinery.error_logger.warn(e.backtrace)
        raise e
      end
    end
  end
end
