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

  context 'impressions', js: true, driver: :webkit_debug do
    let (:video)      { FactoryGirl.create :video_default }
    let (:network)    { FactoryGirl.create :network_default }
    let (:user)       { FactoryGirl.create :user_default }
    
    before do
      # Capybara.javascript_driver = :webkit
    end

    it 'visits a page' do
      
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

      # test find_by_id
      # find(:css, '.iframe-container').trigger(:click)


      sleep 8

      # find('#player').click

      # page.driver.click(150,150)

      within_frame 'player' do
        # begin playing video
        # find('embed').click
        # click(50, 50)
        # page.clickAt('50,50')
        page.should have_css('.full-frame')
        page.should have_css('#player1')
        find(:css, '.full-frame #player1').click #.trigger(:click)
      end
      # find(:css, 'embed').trigger(:click)
      # page.driver.clickAt(find(:css, '#player'),'50,50')

      # wait for bounce to register
      sleep 8

      # bounces increases
      video.count_bounces(network).should == bounces + 1

      # visit embed_path(id: video.id, network_id: network.id)
      # visit user_path(user)
    end

  end

end
