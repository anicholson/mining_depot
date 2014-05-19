require 'spec_helper'

describe Location do
  let(:location) { Location.new }

  it { should be_a MiningDepot::Entity }

  it 'has coordinates' do
    should respond_to :coordinates
  end

  describe 'coordinates' do
    let (:x) { nil }
    let (:y) { nil }
    subject { Location.new(x: x, y: y).coordinates }

    it { should respond_to(:[]) }
    it { should respond_to(:x)  }
    it { should respond_to(:y)  }

    context 'provided' do
      let(:x) { 9 }
      let(:y) { 2 }
      its(:x) { should eq(9) }
      its(:y) { should eq(2) }
    end

    context 'not provided' do
      it 'defaults to the origin' do
        expect(subject.x).to eq(0)
        expect(subject.y).to eq(0)
      end
    end
  end
end
