require 'spec_helper'

describe MoveTruck do
  it_behaves_like 'an Interactor'

  let(:location)  { Location.new }
  let(:current_l) { Location.new(x: 1, y:1) }
  let(:truck)     { Truck.new(location: current_l) }

  describe 'required_inputs:' do
    subject { described_class.run(input) }

    context 'when Truck omitted' do
      let(:input) {{ location: location }}
      it 'fails the validation' do
        MoveTruck.any_instance.should_not_receive(:execute)
        subject
      end
    end

    context 'when Location omitted' do
      let(:input) {{ truck: truck }}
      it 'fails the validation' do
        MoveTruck.any_instance.should_not_receive(:execute)
        subject
      end
    end

    context 'when all provided' do
      let(:input) {{ location: location, truck: truck }}
      it 'runs' do
        MoveTruck.any_instance.should_receive(:execute)
        subject
      end
    end
  end

  describe 'algorithm' do
    subject { described_class.run(input) }
    let(:input) {{ location: location, truck: truck }}

    context 'adjacent grid point' do
      let(:current_l) { Location.new(x: 1, y:0)}

      it { should be_success }
    end

    context 'non-adjacent grid point' do
      let(:current_l) { Location.new(x: 1, y:1)}
      it { should_not be_success }
    end
  end
end
