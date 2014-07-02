require 'spec_helper'

describe Truck do
  it_behaves_like 'an Entity'
  it_behaves_like 'a Receiver'

  describe '#capacity' do
    it { should respond_to :capacity }
    its(:capacity) { should be_a Fixnum }

    it 'is set at creation' do
      truck = Truck.new(capacity: 100)

      truck.capacity.should eq(100)
    end
  end
end
