require 'spec_helper'

shared_examples_for 'an active object' do
  it { should respond_to :semaphore }
  its(:semaphore) { should be_a Mutex }
end
