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

    it 'default to the origin' do
      expect(subject.x).to eq(0)
      expect(subject.y).to eq(0)
    end

    context 'provided' do
      let(:x) { 9 }
      let(:y) { 2 }
      its(:x) { should eq(9) }
      its(:y) { should eq(2) }
    end
  end

  it 'has a name' do
    should respond_to :name
  end

  describe 'name' do
    it 'defaults to "Location " + coordinates' do
      expect(subject.name).to eq('Location (0, 0)')
    end

    context 'when provided' do
      subject { Location.new name: 'Gemfields', x: 5, y:5 }

      it 'contains the provided name' do
        expect(subject.name).to match(/Gemfields/)
      end

      it 'contains the coordinates' do
        expect(subject.name).to match /5, 5/
      end
    end
  end

  describe 'states' do
    [:road?, :mine?, :depot?, :building?].each do |state|
      it { should respond_to(state) }
    end
  end
end
