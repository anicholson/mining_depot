require 'spec_helper'

describe StartMine do
  it_behaves_like 'an Interactor'

  describe 'required inputs:' do
    subject { described_class.run(input)}

    describe 'a mine to start' do
      context 'when provided' do
        let(:input) {{ mine: Mine.new }}

        it 'runs' do
          StartMine.any_instance.should_receive(:execute)

          subject
        end
      end

      context 'when omitted' do
        let(:input) {{ mine: nil }}

        it 'fails' do
          result = subject

          result.should_not be_a_success
        end
      end
    end
  end
end