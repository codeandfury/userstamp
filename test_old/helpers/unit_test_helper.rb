require 'rubygems'
require 'test/unit'
require 'active_record'
require 'active_record/fixtures'
require 'active_support'

# Add locations to the load path
$:.unshift(File.dirname(__FILE__) + '/../..')
$:.unshift(File.dirname(__FILE__) + '/../../lib')

require 'init'
require 'userstamp'
require 'userstamp/migration_helper'
require 'userstamp/stampable'
require 'userstamp/stamper'
require 'userstamp/version'
require 'test/models/comment'
require 'test/models/person'
require 'test/models/ping'
require 'test/models/post'
require 'test/models/user'

# Setup test database tables
schema_file = File.join(File.dirname(__FILE__), '..', 'schema.rb')
config = YAML::load(IO.read(File.join(File.dirname(__FILE__), '..', 'database.yml')))[ENV['DB'] || 'test']
ActiveRecord::Base.configurations = config
ActiveRecord::Base.establish_connection(config)
load(schema_file) if File.exist?(schema_file)


class ActiveSupport::TestCase
  include ActiveRecord::TestFixtures
  self.fixture_path = File.join(File.dirname(__FILE__), '..',  'fixtures')
  
  # Turn off transactional fixtures if you're working with MyISAM tables in MySQL
  self.use_transactional_fixtures = false
  
  # Instantiated fixtures are slow, but give you @david where you otherwise would need people(:david)
  self.use_instantiated_fixtures  = true
  
  self.pre_loaded_fixtures = false
  fixtures :all 
end