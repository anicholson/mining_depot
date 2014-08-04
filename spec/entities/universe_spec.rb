require 'spec_helper'

describe Universe do
  subject { Universe }
  its(:worlds) { should be_a Hash }

  describe 'behaves like a Hash' do
    [:[], :[]=, :count].each {|m| it { should respond_to(m) }}
  end

  it 'can be cleared' do
    Universe.reset!

    Universe['lol'] = Object.new
    subject.should have(1).world
    Universe.reset!
    subject.should have(0).worlds
  end
end
