require 'spec_helper'

describe Truck do
  it_behaves_like 'an Entity'
  it_behaves_like 'an active object'

  describe '#capacity' do
    it { should respond_to :capacity }
    its(:capacity) { should be_a Fixnum }

    it 'is set at creation' do
      truck = Truck.new(capacity: 100)
      truck.capacity.should eq(100)
    end
  end

  describe '#location' do
    it { should respond_to :location }
  end

  describe '#destination' do
    it { should respond_to :destination }
  end

  describe '#navigation' do
    it { should respond_to :navigation }
  end

  describe '#start' do
    it 'runs its behaviour loop' do
      behaviour = double
      truck = Truck.new(behaviour: behaviour)
      expect(behaviour).to receive(:run).at_least(:once)
      truck.start
      sleep 0.1
    end
  end
end
