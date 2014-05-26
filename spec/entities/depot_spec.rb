require 'spec_helper'

describe Depot do
  it_behaves_like 'an Entity'
  it_behaves_like 'an active object'

  it 'has a capacity' do
    should respond_to :capacity
  end
end
