require "pathname"

module Spec
  module Path
    def root_dir
      @root_dir ||= Pathname.new("../../..").expand_path(__FILE__)
    end

    def fixture_path(path)
      File.expand_path("#{root_dir}/spec/fixtures/#{path}", __dir__)
    end
  end
end
