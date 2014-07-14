require 'spec_helper'

describe CreateDemoWorld do
  subject { described_class.run(input).result }

  let(:input) {{ world: { height: 50, width: 20 } }}

  it { should be_a World }
end
