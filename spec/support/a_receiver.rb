require 'spec_helper'

shared_examples_for 'a Receiver' do
  it { should respond_to :receive }
end
