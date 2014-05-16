require 'spec_helper'

describe StartMine do
  it_behaves_like 'an Interactor'

  describe 'required inputs:' do
    let(:mine) { Mine.new minerals: :silver }
    subject { described_class.run(input)}

    describe 'a mine to start' do
      context 'when provided' do
        let(:input) {{ mine: mine }}

        it 'runs' do
          StartMine.any_instance.should_receive(:execute)

          subject
        end

        it 'starts the mine' do
          mine.should_receive :start

          subject
        end
      end

      context 'when omitted' do
        let(:input) {{ mine: nil }}
        it { should_not be_a_success }
      end
    end
  end
end
