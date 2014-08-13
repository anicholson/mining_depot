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
    it { should respond_to :destination}
  end

  describe '#next_location' do
    let (:truck) { Truck.new }
    it { should respond_to :next_location }

    describe 'contract' do
      subject { skip('algorithm will change'); truck.next_location(location) }
      context 'when in a corner' do
        let(:location) { Location.new(x: 0, y: 0) }

        its(:x) { should >= 0 }
      end
    end
  end
end
