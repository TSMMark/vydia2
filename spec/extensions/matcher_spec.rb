require 'spec_helper'

describe 'Custom Matchers' do
  describe :have_value_in do
    subject { FactoryGirl.create :video_default }
    it { should_not have_value_in :wrong_attribute_asodihldf }
    it { should     have_value_in :created_at }
    it { should     have_value_in :updated_at }
  end
end
