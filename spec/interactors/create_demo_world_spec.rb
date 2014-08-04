require 'spec_helper'

describe CreateDemoWorld do
  before  { Universe.reset!                   }
  subject { described_class.run(input).result }

  let(:input) {{ world: { height: 50, width: 20 } }}

  it { should be_a World }

  it 'stores the world in the Universe' do
    Universe.should have(0).worlds
    subject
    Universe.should have(1).world
  end
end
