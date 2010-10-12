# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.8' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem 'twitter', :version => '0.9.12'
# config.frameworks -= [:active_record, :active_resource]
  config.time_zone = 'UTC'
	config.gem "rpx_now"

	config.after_initialize do # so rake gems:install works
		RPXNow.api_key = "2cf28ea4484ba9e0f51dc02c6a81eb027031f733"
	end
end
