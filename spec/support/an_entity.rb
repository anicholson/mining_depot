require 'spec_helper'

shared_examples_for 'an Entity' do
  it { should be_a MiningDepot::Entity }

  it { should respond_to :logger }
end
