require 'mining_depot/version'
require 'mining_depot/interactor'
require 'mining_depot/entity'

Dir[File.expand_path('../entities/**/*.rb', __FILE__)].each { |f| require f }

module MiningDepot
  # Your code goes here...
end
