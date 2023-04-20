require "active_support/all"
require "google/cloud/scheduler/v1"

require_relative "gcp_scheduler/cli"
require_relative "gcp_scheduler/command"
require_relative "gcp_scheduler/scheduler"

module GcpScheduler
  VERSION = Gem.loaded_specs["gcp_scheduler"].version.to_s

  class << self
    def list(gcp_project:, region:, prefix: "")
      GcpScheduler::Command.list(gcp_project: gcp_project, prefix: prefix, region: region)
    end

    def delete(gcp_project:, region:, prefix: "")
      GcpScheduler::Command.delete(gcp_project: gcp_project, prefix: prefix, region: region)
    end

    def create(gcp_project:, region:, scheduler_file_path:, uri:, secret:, time_zone:, prefix: "")
      GcpScheduler::Command.create(gcp_project:         gcp_project,
                                   region:              region,
                                   prefix:              prefix,
                                   scheduler_file_path: scheduler_file_path,
                                   uri:                 uri,
                                   secret:              secret,
                                   time_zone:           time_zone)
    end
  end
end
