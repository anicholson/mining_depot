# encoding: utf-8
require 'mining_depot/entity'

class Depot < MiningDepot::Entity
  attribute :loads,     Hash[Symbol => Float], writer: :private
  attribute :capacity,  Integer,               default: 100

  def initialize(options = {})
    @semaphore = Mutex.new
    @capacity  = options[:capacity]
    @loads     = Hash.new(0)
  end

  def receive_load(loads = {})
    return unless loads.any?
    semaphore.synchronize do
      loads.each do |product, amount|
        @loads[product] += amount
      end
    end
  end

  def send_load(truck, product, amount)
    return false unless available? product, amount

    semaphore.synchronize do
      still_available?(product, amount) and
      truck.receive(product, amount)    and
      @loads[product] -= amount
    end

    true
  end

  def available_space
    semaphore.synchronize do
      return capacity if loads.none?
      return [0, capacity - loads.values.reduce(&:+)].max
    end
  end

  private

  def available?(product, amount)
    amount     = amount.to_i.abs
    available  = loads[product] || 0
    available >= amount
  end

  alias_method :still_available?, :available?
end
