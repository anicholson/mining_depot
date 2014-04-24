require 'spec_helper'

shared_examples_for 'an Interactor' do
  describe 'class methods' do
    subject { described_class }
    it { should respond_to :run }
  end
  
  it { should be_an Interactor }
  it { should respond_to :execute }
end