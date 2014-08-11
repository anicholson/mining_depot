require 'spec_helper'

describe GetWorldView do
  it_behaves_like 'an Interactor'

  describe 'response model:' do
    let(:model) { described_class.run.result }

    before  { CreateDemoWorld.run(world: { height: 50, width: 75 }) }
    subject { model }
    it { should be_an(OpenStruct) }

    describe 'map:' do
      subject { model.map }
      it { should be_a Matrix }

      describe 'dimensions' do
        its(:column_size) { should eq(75) }
        its(:row_size)    { should eq(50) }
      end

      describe 'location:' do
        subject { model.map[20,20] }

        it 'matches the API of a location' do
          [:mine, :depot, :truck].each { |m| subject.should respond_to(m) }
        end
      end
    end

    describe 'counts' do
      subject { model.counts }

      it { should be_an OpenStruct }
      its(:trucks) { should eq(5) }
      its(:mines)  { should eq(10) }
      its(:depots) { should eq(05) }
    end
  end
end
