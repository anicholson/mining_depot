require 'spec_helper'

describe Depot do
  it_behaves_like 'an Entity'
  it_behaves_like 'an active object'

  it 'has a capacity' do
    should respond_to :capacity
  end

  describe 'receive_load' do
    let(:depot) { Depot.new capacity: 10 }

    it 'is thread-safe' do
      expect(depot.semaphore).to receive(:synchronize)
      depot.receive_load(gold: 5)
    end

    it 'updates the available' do
      depot.receive_load(gold: 5)
      expect(depot.available).to eq(5)
    end

    it 'updates the loads' do
      depot.receive_load(gold: 5)
      depot.receive_load(gold: 2)

      expect(depot.loads[:gold]).to eq(7)
    end
  end

  describe '#available' do
    let(:depot) { Depot.new capacity: 10 }

    it 'shows capacity when empty' do
      depot.stub(:loads).and_return({})
      expect(depot.available).to eq(10)
    end

    it 'shows 0 when full' do
      depot.stub(:loads).and_return({gold: 10})
      expect(depot.available).to eq(0)
    end

    it 'shows remaining capacity' do
      depot.stub(:loads).and_return({ gold: 3, silver: 5 })
      expect(depot.available).to eq(2)
    end
  end
end
