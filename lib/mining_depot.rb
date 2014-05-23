# encoding: utf-8
require 'mining_depot/version'
require 'mining_depot/interactor'
require 'mining_depot/entity'
require 'logger'

# rubocop:disable LineLength
%w(entities interactors dsl).each do |src_directory|
  project_files = File.expand_path("../mining_depot/#{src_directory}/**/*.rb", __FILE__)
  Dir[project_files].each { |f| require f }
end

module MiningDepot
end

MiningDepot::Entity.logger = Logger.new('mining_depot.log')
