require 'spec_helper'

describe Truck do
  it { should be_a MiningDepot::Entity }

  describe '#capacity' do
    it { should respond_to :capacity }
    its(:capacity) { should be_a Fixnum }

    it 'is set at creation' do
      truck = Truck.new(capacity: 100)

      truck.capacity.should eq(100)
    end
  end
end
