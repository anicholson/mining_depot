require 'spec_helper'

shared_examples_for 'an Entity' do
  it { should be_a MiningDepot::Entity }

  it { should respond_to :logger }

  describe '#logger' do
    let(:logger) { double('SYSTEM LOGGER') }
    let(:obj) { described_class.new }

    before { MiningDepot::Entity.logger = logger }
    it 'defaults to the system-wide logger if none provided' do
      expect(obj.logger).to be(logger)
    end
  end
end
