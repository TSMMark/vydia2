require 'spec_helper'

describe Network do
  before do
  end

  context 'when creating' do

    it 'has a token with non-digits' do
      10.times do
        n = FactoryGirl.create :network
        n.token.should_not be_numeric
      end
    end
    
  end

end
