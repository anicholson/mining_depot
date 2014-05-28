require 'spec_helper'

shared_examples_for 'an active object' do
  let(:child_class) { Class.new(described_class) }

  subject { child_class.new }
  it { should respond_to :semaphore }
  its(:semaphore) { should be_a Mutex }
end
