require 'spec_helper'

describe User do

  context 'when registering' do
    context 'a trendsetter' do
      let     (:user){ FactoryGirl.create(:user) }
      subject { user }

      it { should be_persisted }
    end

    context 'a non-trendsetter' do
      it 'can\'t register' do
        expect { FactoryGirl.create(:user_non_trendsetter) }.to raise_error
      end
    end

  end
end
