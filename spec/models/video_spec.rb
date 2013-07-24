require 'spec_helper'

describe Video do
  it_should_behave_like :each_spec
  before do
    Video.delete_all
  end

  let (:video)  { FactoryGirl.create :video_default }

  describe 'when creating' do
    it 'has a token with non-digits' do
      10.times do
        n = FactoryGirl.create :video_default
        n.token.should_not be_numeric
        n.delete
      end
    end
  end

  describe 'when finding' do
    let (:id)     { video.id }
    let (:token)  { video.token }
    it { Video.find(token).should == video }
    it { Video.find(id).should    == video }
  end

  describe 'with impressions' do
    let (:video) { FactoryGirl.create :video_with_impressions }

    it { video.count_impressions.should > 0 }
    it { video.impressions.count.should == video.count_impressions }

    context 'networks' do
      it { video.count_networks.should > 0 }

      it { video.count_networks.should == video.networks.all.count }
      it 'network impressions match video impressions' do
        video.networks.each do |n|
          v_i = video.count_impressions(n)
          v_i.should > 0
          v_i.should == n.count_impressions(video)
        end
      end
    end

    it { video.count_plays.should > 0 }
    it { video.count_plays.should == video.plays.count }

    it { video.count_views.should > 0 }
    it { video.count_views.should >= video.count_plays }

    it { video.calculate_spending(100).should == video.cpm * 100.0 / Money.one_thousand }

  end

end

