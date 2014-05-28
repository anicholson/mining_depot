# encoding: utf-8
require 'virtus'

module MiningDepot
  class Entity
    include Virtus.model

    class << self
      attr_accessor :logger
    end

    def logger
      @logger || MiningDepot::Entity.logger
    end

    attribute :semaphore, Mutex, reader: :protected, writer: :private
  end
end
