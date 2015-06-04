# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

# Fixture methods
#require 'fixtures/fixture_methods'
#Dir["#{File.dirname(__FILE__)}/fixtures/fixture_methods/*.rb"].each { |f| require f }

# Support
Dir["#{File.dirname(__FILE__)}/shared_examples/**/*.rb"].each { |f| require f }
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
  config.before(:each) do
    Mongoid.purge!
  end
end
