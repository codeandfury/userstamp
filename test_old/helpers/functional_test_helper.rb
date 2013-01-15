require 'rubygems'
require 'test/unit'
require 'active_record'
require 'active_record/fixtures'
require 'active_support'
require 'active_support/test_case'
require 'action_controller'
require 'action_controller/test_case'
require 'rack'
require 'rack/test'

=begin
require 'rails'
require 'rails/test_help'

source :rubygems
group :test do
  # Pretty printed test output
  gem 'turn', :require => false
  gem 'minitest'                  ####### add this line #######
end
=end

# Add locations to the load path
$:.unshift(File.dirname(__FILE__) + '/../..')
$:.unshift(File.dirname(__FILE__) + '/../../lib')

require 'init'
require 'controllers/userstamp_controller'
require 'controllers/users_controller'
require 'controllers/posts_controller'

# Setup test database tables
schema_file = File.join(File.dirname(__FILE__), '..', 'schema.rb')
ENV["RAILS_ENV"] = "test"
config = YAML::load(IO.read(File.join(File.dirname(__FILE__), '..', 'database.yml')))[ENV['DB'] || 'test']
ActiveRecord::Base.configurations = config
ActiveRecord::Base.establish_connection(config)

ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/models.log")
ActionController::Base.logger = Logger.new(File.dirname(__FILE__) + "/controllers.log")

load(schema_file) if File.exist?(schema_file)


class ActiveSupport::TestCase
  include ActiveRecord::TestFixtures
  self.fixture_path = File.join(File.dirname(__FILE__), '..',  'fixtures')
  
  # Turn off transactional fixtures if you're working with MyISAM tables in MySQL
  self.use_transactional_fixtures = true
  
  # Instantiated fixtures are slow, but give you @david where you otherwise would need people(:david)
  self.use_instantiated_fixtures  = true
  
  self.pre_loaded_fixtures = false
  fixtures :all 
end
