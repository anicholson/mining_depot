require 'spec_helper'

describe StartMine do
  it_behaves_like 'an Interactor'

  describe 'required inputs:' do
    let(:mine) { Mine.new }
    subject { described_class.run(input)}

    describe 'a mine to start' do
      let(:input) {{ mine: mine }}

      it 'starts the mine' do
        mine.should_receive :start
        subject
      end
    end
  end
end
