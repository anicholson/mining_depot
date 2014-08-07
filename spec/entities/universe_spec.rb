require 'spec_helper'

describe Universe do
  subject { Universe }
  its(:worlds) { should be_a Hash }

  describe 'has Hash-like access syntax' do
    [:[], :[]= ].each {|m| it { should respond_to(m) }}
  end

  it 'can be cleared' do
    Universe.reset!

    Universe['lol'] = Object.new
    subject.should have(1).world
    Universe.reset!
    subject.should have(0).worlds
  end
end
