require 'spec_helper'

describe :Embed do
  it_should_behave_like :each_spec
  self.use_transactional_fixtures = false

  context 'sign up' do
    it 'registers successfully' do
      visit root_path
      click_link 'Login'
      
      # login page
      click_link 'Create an account'

      # register page
      fill_in 'Name', with: FactoryGirl.generate(:name)
      fill_in 'Email', with: FactoryGirl.generate(:email)
      fill_in 'Password', with: p=FactoryGirl.generate(:password)
      fill_in 'Password confirmation', with: p

      click_button 'Sign Up'

      current_path.should == root_path

      page.should have_content 'Welcome back'
    end

  end

  # , driver: :webkit_debug
  context 'impressions', js: true do
    before do
      Capybara.current_driver = :webkit
    end

    let (:video)      { FactoryGirl.create :video_default }
    let (:network)    { FactoryGirl.create :network_default }
    let (:user)       { FactoryGirl.create :user_default }
    
    # for some reason we need this in order for the spec below
    it { visit video_path(video) }

    it 'registers impressions, views and plays' do
      visit video_path(video)

      # get starting impressions
      impressions = video.count_impressions(network)

      # page path
      path = embed_path(video.token, network.token)

      # visit page (causing impression)
      visit path
      
      # path should be embed path
      current_path.should == "/videos/#{video.token}/embed/#{network.token}"
      # has an additional impression
      video.count_impressions(network).should == impressions + 1

      # get initial bounces
      bounces = video.count_bounces(network)

      page.should have_css('#player')
      
      wait_until { find_by_id('player').tag_name == 'iframe' }

      page.within_frame 'player' do
        # begin playing video
        page.should have_css('.full-frame')
        page.should have_css('#player1')

        find_by_id('player1').click
      end

      # wait for bounce to register
      wait_until_long { video.count_bounces(network) == bounces + 1 }
    end

  end

end
