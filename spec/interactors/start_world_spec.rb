require 'spec_helper'

describe StartWorld do
  it_behaves_like 'an Interactor'

  describe 'required inputs:' do
    subject { described_class.run(input)}

    describe 'a world to start' do
      context 'when omitted' do
        let(:input) {{ world: nil }}
        it { should_not be_a_success }
      end

      context 'when provided' do
        let(:mine)  { Mine.new(minerals: :silver) }
        let(:truck) { Truck.new }
        let(:input) do
          {
            world: World.new(
              mines: [mine],
              trucks: [truck]
            ),
          }
        end

        it 'starts all the mines' do
          mine.should_receive(:start)
          subject
        end

        it 'starts all the trucks' do
          truck.should_receive(:start)
          subject
        end
      end
    end
  end
end
