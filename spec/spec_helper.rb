ENV["RAILS_ENV"] ||= 'test'

require 'rubygems'
gem 'rspec', '~>2.12.0'
gem "factory_girl", "~> 4.1.0"
require 'active_record'
require 'active_record/fixtures'

require File.dirname(__FILE__) + '/../lib/userstamp'
require_relative 'models/user'
require_relative 'models/person'
require_relative 'models/post'

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"
load 'support/schema.rb'

=begin
RSpec.configure do |config|
  config.mock_with :rspec
  config.fixture_path = "#{File.dirname(__FILE__)}/fixtures"
  config.use_transactional_fixtures = true
  config.global_fixtures = :all
end
=end