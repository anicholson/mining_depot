require 'spec_helper'

describe Mine do
  let(:mine) { Mine.new logger: double, minerals: :silver }
  it { should be_a MiningDepot::Entity }

  describe '#products' do
    let(:result) { mine.products }
    it 'includes all minerals' do
      result.should include(:silver)
    end
  end

  describe '#status' do
    let(:result) { mine.status }
    it { should respond_to :status }
    it 'returns a Hash' do
      result.should be_a Hash
    end

    describe 'return value' do
      subject { result }
      it { should have_key :state }
      it { should have_key :depot }

      its 'state: IS_A Symbol' do
        subject[:state].should be_a Symbol
      end

      its 'depot: IS_A Hash' do
        subject[:depot].should be_a Hash
      end

      its 'depot: has all products' do
        mine.products.each do |product|
          subject[:depot].should have_key product
        end
      end

      context 'newly created' do
        it 'is :stopped' do
          subject[:state].should eq :stopped
        end
      end
    end
  end

  describe '#start' do
    context 'when mine is stopped' do
      it 'starts the mine' do
        result = subject.start
        result.should eq :started
      end

      it 'locks before changing status' do
        subject.semaphore.should_receive :synchronize
        subject.start
      end

      it 'changes the status' do
        subject.start
        subject.status[:state].should eq :started
      end
    end

    context 'when mine already running' do
      before { subject.instance_variable_set(:@state, :started) }
      it 'does not signal the machinery' do
        subject.trigger.should_not_receive :broadcast
        subject.start
      end
    end
  end

  describe '#stop' do
    context 'when mine is stopped' do
      it 'does not sigal the machinery' do
        subject.trigger.should_not_receive :broadcast
        subject.stop
      end

      it 'does not change the status' do
        subject.status[:state].should eq :stopped
        subject.stop
        subject.status[:state].should eq :stopped
      end
    end

    context 'when mine is started' do
      before { subject.instance_variable_set(:@state, :started) }

      it 'signals the machinery' do
        subject.trigger.should_receive :broadcast
        subject.stop
      end

      it 'stops the mine' do
        result = subject.stop
        result.should eq :stopped
      end

      it 'locks before changing status' do
        subject.semaphore.should_receive(:synchronize).at_least(:once)
        subject.stop
      end

      it 'changes the status' do
        subject.stop
        subject.status[:state].should eq :stopped
      end
    end
  end

  describe '#machine' do
    let(:logger) { double('logger', warn: true) }
    let(:mine) { Mine.new logger: logger, minerals: :copper }
    it { mine.instance_variable_get(:@machinery).should be_a Mine::Machinery }

    it 'logs when the mine is in a strange state' do
      Mine::Machinery.any_instance.stub(:mine_state).and_return(:WAT)
      m = Mine.new logger: logger, minerals: :lol
      sleep(0.01)
      expect(logger).to have_received(:warn)
    end
  end

  describe 'product' do
    subject { mine }
    it { should respond_to :products }
    it 'returns an array of Symbol' do
      subject.products.should be_an Array
      subject.products.each { |prod| prod.should be_a Symbol }
    end
  end

  its(:semaphore) { should be_a Mutex }
end
