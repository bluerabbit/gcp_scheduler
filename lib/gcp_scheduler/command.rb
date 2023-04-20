module GcpScheduler
  class Command
    class << self
      def list(gcp_project:, region:, prefix: "")
        scheduler = Scheduler.new(project: gcp_project, location: region)
        scheduler.jobs.each do |job|
          scheduler_name = job.name.split("/").last
          next unless scheduler_name.start_with?(prefix)

          puts "- name:#{scheduler_name} description:#{job.description} schedule:#{job.schedule}"
        end
      end

      def delete(gcp_project:, region:, prefix: "")
        scheduler = Scheduler.new(project: gcp_project, location: region)
        scheduler.jobs.each do |job|
          scheduler_name = job.name.split("/").last
          next unless scheduler_name.start_with?(prefix)

          puts "Delete #{scheduler_name}"
          scheduler.delete_job(scheduler_name)
          puts "Deleted #{scheduler_name}"
        end
      end

      def create(gcp_project:, region:, scheduler_file_path:, uri:, secret:, time_zone:, prefix: "")
        scheduler = Scheduler.new(project: gcp_project, location: region)
        Scheduler.scheduler_config(scheduler_file_path).each do |name, h|
          scheduler_name = "#{prefix}#{name}"
          puts "Create #{scheduler_name}"
          scheduler.create_job(name:        scheduler_name,
                               description: "#{h["class"]} CreatedAt:#{Time.current.strftime("%Y/%m/%d %-H:%M")}",
                               uri:         uri,
                               schedule:    h["cron"],
                               params:      { job_name: name },
                               secret:      secret,
                               time_zone:   time_zone)
          puts "Created #{scheduler_name}"
        end
      end
    end
  end
end
