# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mining_depot/version'

Gem::Specification.new do |spec|
  spec.name          = 'mining_depot'
  spec.version       = MiningDepot::VERSION
  spec.authors       = ['Andy Nicholson']
  spec.email         = ['andrew@anicholson.net']
  spec.description   = %q{A project to test Bob Martin's architecture style}
  spec.summary       = %q{A small mining/distribution simulator}
  spec.homepage      = 'https://github.com/anicholson/mining_depot'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'mutations'
  spec.add_dependency 'virtus'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'turnip'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'simplecov-rcov'
  spec.add_development_dependency 'pry'
end
