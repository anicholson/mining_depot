require 'spec_helper'

shared_examples_for 'an active object' do
  let(:child_class) { Class.new(described_class) }

  subject { child_class.new }
  before  { child_class.send(:public, *child_class.protected_instance_methods) }
  it { should respond_to :semaphore }
  its(:semaphore) { should be_a Mutex }
end
