# Be sure to restart your server when you modify this file.

# You can add backtrace silencers for libraries that you're using but don't wish to see in your backtraces.
# Rails.backtrace_cleaner.add_silencer { |line| line =~ /my_noisy_library/ }

# You can also remove all the silencers if you're trying to debug a problem that might stem from framework code.
# Rails.backtrace_cleaner.remove_silencers!

# config/initializers/application.rb
#require 'my_modules'
#require 'my_modules/active_record/active_record_extensions'
# ... require any other custom modules your application uses

Dir[Rails.root.join("lib/includes/**/*.rb")].each { |f| require f }