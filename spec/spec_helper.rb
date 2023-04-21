$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "pry"
require "rspec"
require "active_support/testing/time_helpers"
require "gcp_scheduler"
require_relative "support/path"

RSpec.configure do |config|
  config.include Spec::Path
  config.include ActiveSupport::Testing::TimeHelpers
end
