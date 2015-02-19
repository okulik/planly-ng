require 'capybara/rspec'
require 'capybara/poltergeist'

Capybara.register_driver :poltergeist_debug do |app|
  Capybara::Poltergeist::Driver.new(app, inspector: true, debug: true)
end
Capybara.javascript_driver = :poltergeist_debug
Capybara.default_wait_time = 5