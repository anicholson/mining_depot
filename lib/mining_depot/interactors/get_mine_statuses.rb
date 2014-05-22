# encoding: utf-8
require 'mining_depot/interactor'

class GetMineStatuses < Interactor
  required do
    array :mines, class: Mine
  end

  def execute
    mines.map(&:status)
  end
end
