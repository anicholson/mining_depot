require 'spec_helper'

describe MiningDepot::Universe do
  subject { MiningDepot::Universe }
  its(:worlds) { should be_a Hash }

  describe 'has Hash-like access syntax' do
    [:[], :[]= ].each {|m| it { should respond_to(m) }}
  end

  it 'can be cleared' do
    MiningDepot::Universe.reset!

    MiningDepot::Universe['lol'] = Object.new
    subject.should have(1).world
    MiningDepot::Universe.reset!
    subject.should have(0).worlds
  end
end
