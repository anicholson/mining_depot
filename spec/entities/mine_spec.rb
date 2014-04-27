require 'spec_helper'

describe Mine do
  it { should be_a MiningDepot::Entity }

  describe 'status' do
    let(:result) { Mine.new.status }
    it { should respond_to :status }
    it 'returns a Hash' do
      result.should be_a Hash
    end

    describe 'return value' do
      subject { result }
      it { should have_key :state }
      its 'state: IS_A Symbol' do
        subject[:state].should be_a Symbol
      end

      context 'newly created' do
        it 'is :stopped' do
          subject[:state].should == :stopped
        end
      end
    end
  end

  describe 'start' do
    context 'mine is stopped' do
      it 'starts the mine' do
        result = subject.start
        result.should == :started
      end

      it 'locks before changing status' do
        subject.semaphore.should_receive :synchronize
	subject.start
      end

      it 'changes the status' do
        subject.instance_variable_get(:@machinery).should_receive :run
        subject.start
        subject.status[:state].should == :started
      end
    end
  end

  describe 'product' do
    it { should respond_to :product }
    it 'returns a Symbol' do
      subject.product.should be_a Symbol
    end
  end

  its(:semaphore) { should be_a Mutex }
end
