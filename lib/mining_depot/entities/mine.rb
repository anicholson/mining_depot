require 'mining_depot/entity'
require 'logger'

class Mine < MiningDepot::Entity
  attr_accessor :semaphore, :logger, :trigger

  class Machinery < Thread
    attr_reader :error_logger

    def self.next_mine_number
      @id ||= 0
      @id +=  1
    end

    def initialize(_)
      @error_logger = Logger.new('errors.log')
      super(_)
    end
  end

  def initialize
    @logger    = MiningDepot::Entity.logger
    @state     = :stopped
    @semaphore = Mutex.new
    @trigger   = ConditionVariable.new
    @machinery = machine
  end

  def status
    {
      state: @state
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

  def product
    :gold
  end

  private

  # rubocop:disable MethodLength
  def machine
    Machinery.new(self) do |m|
      begin
        mine_number = Machinery.next_mine_number
        state       = nil

        loop do
          m.semaphore.synchronize { state = m.status[:state] }

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
        error_logger.warn(e.message)
        error_logger.warn(e.backtrace)
        raise e
      end
    end
  end
end
