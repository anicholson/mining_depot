require 'spec_helper'

describe World do
  it_behaves_like 'an Entity'

  describe 'visible objects' do
    [:mines, :trucks, :depots].each do |meth|
      it { should respond_to(meth) }
    end
  end

  describe 'dimensions' do
    [:width, :height].each do |dim|
      it { should respond_to(dim) }
      its(dim) { should be_an(Integer) }
    end
  end
end
