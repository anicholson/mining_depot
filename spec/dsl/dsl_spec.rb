require 'spec_helper'

describe MiningDepot::DSL do
  let(:dummy_class) { Class.new { include MiningDepot::DSL }}
  describe '#mine' do
    subject { dummy_class.new}
    it 'returns a Mine' do
      expect(subject.mine { }).to be_a Mine
    end

    it 'requires a block' do
      expect{subject.mine}.to raise_exception
    end
  end
end
