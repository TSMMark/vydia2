require 'spec_helper'

describe Youtube do
  let   (:youtube) { FactoryGirl.build :youtube }
  subject { youtube }

  context 'initialization' do
    subject { youtube }
    it { should_not be_persisted }
    it { should have_value_in :title }
    it { should have_value_in :base_thumb_url }
    it { should have_value_in :yt_rating }
    it { should have_value_in :max_rating }
    it { should have_value_in :min_rating }
    it { should have_value_in :rating_100 }
    it { should have_value_in :view_count }
    it { should have_value_in :favorite_count }

    it { should have_value_in :thumb }
  end

  context :rating_100 do
    subject { youtube.rating_100 }
    it { should     be_between 0, 100 }
    it { should_not be_negative }
  end

  context :yt_rating do
    subject { youtube.yt_rating }
    it { should     be_between youtube.min_rating, youtube.max_rating }
    it { should     be_positive }
  end

  context :min_and_max_ratings do
    subject { youtube }
    it 'matches min and max ratings' do
      subject.max_rating.should == 5
      subject.min_rating.should == 1
    end
  end

  context :yt_attributes do
    subject { youtube }
    it { subject.view_count.should_not      be_negative }
    it { subject.favorite_count.should_not  be_negative }
    it { subject.favorite_count.should_not  be_negative }
  end

  context :thumb do
    subject { youtube.thumb }
    it { should be_uri }
    context :request do
      subject { REQUEST.get_response(youtube.thumb) }
      it { subject.content_type.should == 'image/jpeg' }
    end
  end

end
