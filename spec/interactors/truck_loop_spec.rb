require 'spec_helper'

describe TruckLoop do
  it_behaves_like 'an Interactor'

  before do
    Truck.any_instance
         .stub(:next_location)
         .and_return(double('loc', coordinates: []))
  end

  let(:location) { Location.new }
  let(:truck)    { Truck.new(location: location) }

  it 'attempts to move the Truck' do
    MoveTruck.should_receive(:run).and_return(double('result', :success? => true))
    TruckLoop.run(truck: truck)
  end
end
