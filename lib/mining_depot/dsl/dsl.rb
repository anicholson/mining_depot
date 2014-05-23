# encoding: utf-8
require 'mining_depot'

module MiningDepot
  module DSL
    def mine(&block)
      fail if block.nil?
      @mines ||= []
      Mine.new.tap { |m| @mines << m }
    end
  end
end
