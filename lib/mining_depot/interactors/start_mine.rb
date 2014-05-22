# encoding: utf-8
require 'mining_depot/interactor'

class StartMine < Interactor
  required do
    model :mine
  end

  def execute
    mine.start
  end
end
