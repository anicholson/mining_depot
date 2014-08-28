require 'spec_helper'

describe World do
  it_behaves_like 'an Entity'

  describe 'visible objects' do
    [:mines, :trucks, :depots].each do |meth|
      it { should respond_to(meth) }
    end

    describe '#trucks_at?' do
      it 'returns false when no trucks' do
        location = subject[0,0]
        expect(subject.trucks_at?(location)).to eq(false)
      end

      it 'returns true when there is a truck' do
        location = Location.new(x: 5, y:5)
        subject.stub(:trucks).and_return([Truck.new(location: location)])
        expect(subject.trucks_at?(location)).to eq(true)
      end
    end
  end

  describe 'dimensions' do
    [:width, :height].each do |dim|
      it { should respond_to(dim) }
      its(dim) { should be_an(Integer) }
    end
  end
end
