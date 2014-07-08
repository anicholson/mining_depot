require 'spec_helper'

describe World do
  it_behaves_like 'an Entity'

  describe 'visible objects' do
    [:mines, :trucks, :depots].each do |meth|
      it { should respond_to(meth) }
    end
  end
end
