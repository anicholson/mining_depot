require 'spec_helper'

describe FindAvailableDestinations do
  it_behaves_like 'an Interactor'

  let(:truck) { Truck.new }
  let(:world) { CreateDemoWorld.run(world: { height: 20, width: 20}).result }

  before { truck.location = world[0,0] }

  describe 'algorithm' do
    subject { described_class.run(world: world, truck: truck).result}

    context 'when Truck is empty' do
      before { truck.stub(:empty?).and_return(true) }

      it('returns an array of Mines') do
        expect(subject).to be_an Array
        subject.each {|m| m.should be_a Mine }
      end
    end

    context 'when Truck is loaded' do
      before { truck.stub(:empty?).and_return(false) }

      it('returns an array of Depots') do
        expect(subject).to be_an Array
        subject.each {|d| d.should be_a Depot }
      end
    end
  end
end
