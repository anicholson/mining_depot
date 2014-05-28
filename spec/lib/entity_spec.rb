require 'spec_helper'

describe MiningDepot::Entity do
  subject { described_class }

  its(:ancestors) { should include Virtus::Model::Core }


end
