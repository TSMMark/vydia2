require 'spec_helper'

describe Network do
  let (:network)  { FactoryGirl.create :network_default }

  it { Network.default_split.should be_a Float }
  it { Network.default_split.should be_between(0,1) }
  it { Network.offered_cpm(50).should be_a Float }
  it { Network.offered_cpm(50).should < 50 }

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

  describe 'with impressions' do
    let (:video)    { FactoryGirl.create :video_with_impressions }
    let (:network)  { video.networks.first }

    it { network.count_impressions.should > 0 }
    it { network.impressions.count.should == network.count_impressions }

    context 'videos' do
      it { network.count_videos.should > 0 }

      it { network.count_videos.should == network.videos.all.count }
      it 'network impressions match video impressions' do
        network.videos.all.each do |v|
          n_i = network.count_impressions(v)
          n_i.should > 0
          n_i.should == v.count_impressions(network)
        end
      end
    end

    it { network.count_plays.should > 0 }
    it { network.count_plays.should == network.plays.count }

    it { network.count_views.should > 0 }
    it { network.count_views.should >= network.count_plays }

    it { network.count_views.should be_between(
         network.count_plays, network.count_impressions) }

    # it { network.calculate_spending(100).should == network.cpm * 100.0 / Money.one_thousand }

    it { network.vydia_revenue.should > 0 }

    it { network.revenue.should > 0 }

    it { network; Network.vydia_revenue.should > 0 }

  end


end
