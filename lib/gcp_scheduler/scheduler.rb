module GcpScheduler
  class Scheduler
    attr_reader :parent

    class << self
      def scheduler_config(file_path)
        YAML.safe_load(ERB.new(File.read(file_path)).result, aliases: true).with_indifferent_access
      end
    end

    def initialize(project:, location:)
      @parent = "projects/#{project}/locations/#{location}"
    end

    def client
      @client ||= ::Google::Cloud::Scheduler::V1::CloudScheduler::Client.new
    end

    def jobs
      client.list_jobs(parent: parent).map {|job| job }
    end

    def create_job(name:,
                   description:,
                   uri:,
                   schedule:,
                   time_zone:,
                   params: {},
                   http_method:,
                   headers: {})

      job = {
        name:        "#{parent}/jobs/#{name}",
        description: description,
        schedule:    schedule,
        time_zone:   time_zone,
        http_target: {
          uri:         uri,
          http_method: http_method,
          body:        params.to_json,
          headers:     headers
        },
      }

      client.create_job parent: parent, job: job
    end

    def delete_job(name)
      client.delete_job name: "#{parent}/jobs/#{name}"
    end
  end
end
