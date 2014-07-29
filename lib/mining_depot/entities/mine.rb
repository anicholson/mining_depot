# encoding: utf-8

require 'mining_depot/entity'
require 'mining_depot/entities/location'
require 'logger'

class Mine < MiningDepot::Entity
  attribute :speed,    Integer,       default: 1
  attribute :minerals, Array[Symbol], default: [:silver]
  attribute :storage,  Hash[Symbol => Integer]
  attribute :location, ::Location

  attr_accessor :semaphore, :logger, :trigger

  class Machinery < Thread
    attr_reader :error_logger

    def self.next_mine_number
      @id ||= 0
      @id +=  1
    end

    def initialize(mine)
      @error_logger = Logger.new('errors.log')
      @mine = mine
      self.abort_on_exception = true
      super(mine)
    end

    def mine_state
      @mine.semaphore.synchronize { @mine.status[:state] }
    end
  end

  def initialize(options = {})
    super(options)
    @logger    = options[:logger] || MiningDepot::Entity.logger
    @state     = :stopped
    @semaphore = Mutex.new
    @trigger   = ConditionVariable.new
    @machinery = machine
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

  alias_method :products, :minerals

  def depot_storage
    x = snapshot(:storage)
    products.each_with_object(x) { |m, h| h[m] ||= 0 }
  end

  def available?
    true # for now, all mines are always available. TODO: Add criteria
  end

  private

  def snapshot(attribute)
    send(attribute)
  end

  # rubocop:disable MethodLength
  def machine
    Machinery.new(self) do |m|
      begin
        mine_number = Machinery.next_mine_number
        loop do
          state = Thread.current.mine_state
          case state
          when :started
            m.logger.info "#{mine_number}: mining #{minerals}"
            m.semaphore.synchronize { m.storage[m.minerals.first] += 1 }
            sleep m.speed
          when :stopped
            m.semaphore.synchronize { m.trigger.wait(m.semaphore) }
          else
            m.logger.warn("#{mine_number}: Unknown mine state #{state}")
            sleep m.speed
          end
        end
      rescue => e
        Thread.current.error_logger.warn(e.message)
        Thread.current.error_logger.warn(e.backtrace)
        raise e
      end
    end
  end
end
