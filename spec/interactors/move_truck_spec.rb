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
      it 'has moved' do
        subject
        expect(truck.location.coordinates.x).to eq(location.coordinates.x)
        expect(truck.location.coordinates.y).to eq(location.coordinates.y)
      end
    end

    context 'non-adjacent grid point' do
      let(:current_l) { Location.new(x: 1, y:1)}
      it { should_not be_success }
      it 'has not moved' do
        subject
        expect(truck.location.coordinates.x).to eq(current_l.coordinates.x)
        expect(truck.location.coordinates.y).to eq(current_l.coordinates.y)
      end
    end
  end

  describe 'error handling' do
    let(:interactor) { MoveTruck.new }
    let(:code) do
      interactor.guard_against(:_, :_) { fail 'Something horrible happened' }
    end

    it 'rescues from exceptions' do
      expect { code }.to throw_symbol(:precondition_failure)
    end

    it 'captures the error' do
      interactor.should_receive(:add_error).with(:system, :error, 'Something horrible happened')
      catch(:precondition_failure) { code }
    end
  end
end
