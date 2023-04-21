require "active_support/all"
require "google/cloud/scheduler/v1"

require_relative "gcp_scheduler/cli"
require_relative "gcp_scheduler/command"
require_relative "gcp_scheduler/scheduler"

module GcpScheduler
  VERSION = Gem.loaded_specs["gcp_scheduler"].version.to_s

  class << self
    def list(gcp_project:, region:, prefix: "")
      command = GcpScheduler::Command.new(gcp_project: gcp_project, region: region)
      command.list(prefix: prefix)
    end

    def delete(gcp_project:, region:, prefix: "")
      command = GcpScheduler::Command.new(gcp_project: gcp_project, region: region)
      command.delete(prefix: prefix)
    end

    def create(gcp_project:, region:, scheduler_file_path:, prefix: "")
      command = GcpScheduler::Command.new(gcp_project: gcp_project, region: region)
      command.create(prefix: prefix, scheduler_file_path: scheduler_file_path)
    end
  end
end
