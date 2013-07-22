require 'spec_helper'

describe Video do
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

  describe 'with plays' do
    let (:video) { FactoryGirl.create :video_with_impressions }
    it { video.count_impressions.should > 0 }
    it { video.impressions.count.should == video.count_impressions }
    it { video.networks.count.should > 0 }

    it '' do

    end

    it 'network impressions match video impressions' do
      video.networks.each do |n|
        v_i = video.count_impressions(n)
        v_i.should > 0
        v_i.should == n.count_impressions(video)
      end
    end
  end

end

