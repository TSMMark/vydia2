require 'spec_helper'

describe Network do
  let (:network)  { FactoryGirl.create :network_default }

  describe 'when creating' do
    it 'has a token with non-digits' do
      10.times do
        n = FactoryGirl.create :network_default
        n.token.should_not be_numeric
      end
    end
  end

  describe 'when finding' do
    let (:id)     { network.id }
    let (:token)  { network.token }
    it { Network.find(token).should == network }
    it { Network.find(id).should    == network }
  end

end
