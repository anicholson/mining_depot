require 'spec_helper'

describe CreateDemoWorld do
  before  { MiningDepot::Universe.reset!      }
  subject { described_class.run(input).result }

  let(:input) {{ world: { height: 50, width: 20 } }}

  it { should be_a World }

  it 'stores the world in the Universe' do
    MiningDepot::Universe.should have(0).worlds
    subject
    MiningDepot::Universe.should have(1).world
  end

  it('generates mines')  { expect(subject.mines.count).to_not  eq(0) }
  it('generates depots') { expect(subject.depots.count).to_not eq(0) }
  it('generates trucks') { expect(subject.trucks.count).to_not eq(0) }
end
