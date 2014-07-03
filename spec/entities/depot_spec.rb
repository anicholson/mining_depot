require 'spec_helper'

describe Depot do
  it_behaves_like 'an Entity'
  it_behaves_like 'an active object'

  it 'has a capacity' do
    should respond_to :capacity
  end

  let(:depot) { Depot.new capacity: 10 }

  describe 'receive_load' do

    it 'is thread-safe' do
      expect(depot.instance_variable_get(:@semaphore)).to receive(:synchronize)
      depot.receive_load(gold: 5)
    end

    it 'updates the available' do
      depot.receive_load(gold: 5)
      expect(depot.available_space).to eq(5)
    end

    it 'updates the loads' do
      depot.receive_load(gold: 5)
      depot.receive_load(gold: 2)

      expect(depot.loads[:gold]).to eq(7)
    end
  end

  describe 'send_load' do
    before { depot.receive_load(gold: 10) }
    let(:truck) { Truck.new capacity: 10 }

    it 'is thread-safe' do
      expect(depot.instance_variable_get(:@semaphore)).to receive(:synchronize)
      depot.send_load(truck, :gold, 0)
    end

    it 'reconfirms product is available' do
      depot.should receive(:available?).once.and_return(true)
      depot.should receive(:still_available?).once.and_return(true)
      depot.send_load(truck, :gold, 0).should be_true
    end
  end

  describe '#available_space' do
    it 'shows capacity when empty' do
      depot.stub(:loads).and_return({})
      expect(depot.available_space).to eq(10)
    end

    it 'shows 0 when full' do
      depot.stub(:loads).and_return({gold: 10})
      expect(depot.available_space).to eq(0)
    end

    it 'shows remaining capacity' do
      depot.stub(:loads).and_return({ gold: 3, silver: 5 })
      expect(depot.available_space).to eq(2)
    end
  end
end
