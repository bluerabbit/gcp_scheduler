require "active_support/all"
require "thor"
require "gcp_scheduler"

# require environment variables for GCP API
# export GOOGLE_APPLICATION_CREDENTIALS=credential.json
module GcpScheduler
  class Cli < Thor
    def self.exit_on_failure?
      true
    end

    default_command :list

    desc "list", "Show schedules"
    method_option :gcp_project, type: :string, required: true
    method_option :region, type: :string, default: "asia-northeast1"
    method_option :prefix, type: :string, default: ""
    def list
      GcpScheduler.list(gcp_project: options[:gcp_project],
                        region:      options[:region],
                        prefix:      options[:prefix])
    end

    desc "delete", "Delete schedules"
    method_option :gcp_project, type: :string, required: true
    method_option :region, type: :string, default: "asia-northeast1"
    method_option :prefix, type: :string, default: ""
    def delete
      GcpScheduler.delete(gcp_project: options[:gcp_project],
                          region:      options[:region],
                          prefix:      options[:prefix])
    end

    desc "create", "Create schedules from scheduler.yml"
    method_option :gcp_project, type: :string, required: true
    method_option :region, type: :string, required: true
    method_option :scheduler_file, type: :string, required: true
    method_option :prefix, type: :string, default: ""
    def create
      GcpScheduler.create(gcp_project:         options[:gcp_project],
                          region:              options[:region],
                          prefix:              options[:prefix],
                          scheduler_file_path: options[:scheduler_file])
    end

    desc "version", "Show Version"

    def version
      say "Version: #{GcpScheduler::VERSION}"
    end
  end
end
