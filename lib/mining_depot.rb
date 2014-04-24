require 'mining_depot/version'
require 'mining_depot/interactor'
require 'mining_depot/entity'

project_files = File.expand_path('../mining_depot/entities/**/*.rb', __FILE__)

Dir[project_files].each { |f| require f }

module MiningDepot
end
