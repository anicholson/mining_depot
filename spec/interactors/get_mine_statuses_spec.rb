require 'spec_helper'

describe GetMineStatuses do
  it_behaves_like 'an Interactor'

  describe 'input validations' do
    let(:result) { GetMineStatuses.run(input) }

    context 'with no inputs' do
      let(:input) { Hash.new }
      it { expect(result).not_to be_success }
    end

    context 'with wrong input' do
      let(:input) { { mines: 2 }}
      it { expect(result).not_to be_success }
    end

    context 'with array of incorrect objects' do
      let(:input) { { mines: [1,2,3] }}
      it { expect(result).not_to be_success }
    end
  end

  it 'calls status on each Mine provided' do
    mines = []
    3.times { mines << Mine.new }

    mines.each {|m| m.should receive(:status) }

    GetMineStatuses.run(mines: mines)
  end
end
