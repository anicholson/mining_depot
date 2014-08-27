require 'spec_helper'

describe GetMineStatuses do
  it_behaves_like 'an Interactor'

  let(:outcome) { GetMineStatuses.run(input) }

  context 'with no inputs' do
    let(:input) { Hash.new }
    it { expect(outcome).not_to be_success }
  end

  context 'with wrong input' do
    let(:input) { { mines: 2 }}
    it { expect(outcome).not_to be_success }
  end

  context 'with array of incorrect objects' do
    let(:input) { { mines: [1,2,3] }}
    it { expect(outcome).not_to be_success }
  end

  context 'with good input' do
    let(:mines) { (1..3).map { Mine.new } }
    let(:input) { { mines: mines } }

    it { expect(outcome).to be_success }

    it 'returns a status for each Mine provided' do
      expect(outcome.result.length).to eq(3)
    end
  end
end
