# Credit goes to http://codingdaily.wordpress.com/2011/01/14/test-a-gem-with-the-rails-3-stack/ for pointing me in the right direction

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

ENV["RAILS_ENV"] ||= 'test'

require 'rubygems'
gem 'actionpack', '>= 3.0.0'
gem 'activesupport', '>= 3.0.0'
gem 'activemodel', '>= 3.0.0'
gem 'railties', '>= 3.0.0'

# Only the parts of rails we want to use
# if you want everything, use "rails/all"
require "action_controller/railtie"
require "rails/test_unit/railtie"
require 'active_record'

root = File.expand_path(File.dirname(__FILE__))

# Define the application and configuration
module Config
  class Application < ::Rails::Application
    # configuration here if needed
    config.active_support.deprecation = :stderr 
  end
end

# Initialize the application
Config::Application.initialize!

require 'rspec/rails'

RSpec.configure do |config|
end

require 'userstamp'

# Generate the database for the tests to run against
ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"
load 'support/schema.rb'