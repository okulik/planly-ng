# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

# Add additional requires below this line. Rails is not loaded until this point!
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'capybara/rails'
require 'devise'

ActiveRecord::Migration.maintain_test_schema!

Capybara.javascript_driver = :poltergeist

# Includes rack-rewrite configuration so HTML5 pushState can function properly.
Capybara.app = Rack::Builder.new do
  eval File.read(Rails.root.join('config.ru'))
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.infer_spec_type_from_file_location!
  config.order = 'random'

  #config.use_transactional_examples = false
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  # ActiveRecord::ConnectionAdapters::ConnectionPool.class_eval do
  #   def current_connection_id
  #     Thread.main.object_id
  #   end
  # end

  # config.before(:all, type: :feature) do
  #   system("grunt build --gruntfile #{Rails.configuration.gruntfile_location}")
  # end
 
  # config.after(:all, type: :feature) do
  #   FileUtils.rm_rf(Rails.root.join("public"))
  # end

  config.include Devise::TestHelpers, type: :controller
end

# hack by Jose Valim
# class ActiveRecord::Base
#   mattr_accessor :shared_connection
#   @@shared_connection = nil

#   def self.connection
#     @@shared_connection || retrieve_connection
#   end
# end
# ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection

# hack by Mike Perham
# class ActiveRecord::Base
#   mattr_accessor :shared_connection
#   @@shared_connection = nil

#   def self.connection
#     @@shared_connection || ConnectionPool::Wrapper.new(:size => 1) { retrieve_connection }
#   end
# end
# ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection