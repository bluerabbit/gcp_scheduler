$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "pry"
require "rspec"

require "gcp_scheduler"
require_relative "support/path"

RSpec.configure do |config|
  config.include Spec::Path
end
