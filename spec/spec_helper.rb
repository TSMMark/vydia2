# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# FactoryGirl
require 'factory_girl_rails'
# FactoryGirl.find_definitions

# capybara poltergeist
# require 'capybara/poltergeist'
# require 'capybara'

# Capybara.register_driver :poltergeist do |app|
#   options = {
#     debug: true, window_size: [1024, 768],
#     phantomjs_options: ['--web-security=no']
#   }
#   Capybara::Poltergeist::Driver.new(app, options)
# end
# Capybara.javascript_driver = :poltergeist

# Capybara.register_driver :poltergeist do |app|
#   options = {
#     # debug: true,
#     window_size: [1024, 768],
#     # phantomjs_options: ['--web-security=no'],
#     inspector: true
#   }
#   Capybara::Poltergeist::Driver.new(app, options)
# end

# # Capybara.javascript_driver = :poltergeist
# Capybara.javascript_driver = :poltergeist


# require 'capybara/poltergeist'
# Capybara.register_driver :selenium do |app|
  # Capybara::Selenium::Driver.new(app, :browser => :chrome)
# end
# Capybara.javascript_driver = :selenium

require 'capybara'
require 'capybara-webkit'
Capybara.javascript_driver = :webkit_debug


# Capybara.register_driver :selenium do |app|
#   profile = Selenium::WebDriver::Firefox::Profile.new
#   profile.native_events = true
#   Capybara::Selenium::Driver.new(app, :browser => :firefox, profile: profile)
# end
# Capybara.register_driver :poltergeist_debug do |app|
#   Capybara::Poltergeist::Driver.new(app, :inspector => true)
# end

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# clean db from last tests
require 'database_cleaner'
def clean_db
  DatabaseCleaner.strategy = :truncation
  DatabaseCleaner.clean
end
clean_db

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end

class ActionController::TestCase
  include Devise::TestHelpers
end

module SpecHelper
  class PlayHelper
    def self.randomize_states
      Play.where("state IS NULL OR state == 0").all.each do |p|
        p.state = (0..4).sample
        p.save!
      end
    end
  end
end

module Capybara
  module Node
    class Element
      # def hover
      #   @session.driver.browser.action.move_to(self.native).perform
      # end
      def trigger event
        self.send(event)
        # @session.driver.browser.action.move_to(self.native).perform
      end
    end
  end
end




