module GcpScheduler
  class Command
    attr_reader :scheduler

    def initialize(gcp_project:, region:)
      @scheduler = Scheduler.new(project: gcp_project, location: region)
    end

    def list(prefix: "")
      scheduler.jobs.each do |job|
        scheduler_name = job.name.split("/").last
        next unless scheduler_name.start_with?(prefix)

        puts "- name:#{scheduler_name} description:#{job.description} schedule:#{job.schedule}"
      end
    end

    def delete(prefix: "")
      scheduler.jobs.each do |job|
        scheduler_name = job.name.split("/").last
        next unless scheduler_name.start_with?(prefix)

        puts "Delete #{scheduler_name}"
        scheduler.delete_job(scheduler_name)
        puts "Deleted #{scheduler_name}"
      end
    end

    def create(scheduler_file_path:, prefix: "")
      Scheduler.scheduler_config_jobs(file_path: scheduler_file_path, job_name_prefix: prefix).each do |job|
        puts "Create #{job[:name]}"
        scheduler.create_job(name:        job[:name],
                             description: job[:description],
                             uri:         job[:uri],
                             schedule:    job[:schedule],
                             time_zone:   job[:time_zone],
                             params:      job[:params],
                             http_method: job[:http_method],
                             headers:     job[:http_headers])
        puts "Created #{job[:name]}"
      end
    end
  end
end
