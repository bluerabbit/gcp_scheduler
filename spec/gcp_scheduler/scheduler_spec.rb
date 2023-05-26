require "spec_helper"

describe GcpScheduler::Scheduler do
  describe "#scheduler_config" do
    before do
      travel_to Time.parse("2023/4/1 10:00")
      ENV["SECRET"] = "secret_key"
    end

    after do
      travel_back
    end

    it do
      path   = fixture_path("scheduler.yml")
      config = GcpScheduler::Scheduler.scheduler_config(path)
      jobs   = config[:jobs]
      expect(jobs.size).to eq(1)
      job = jobs.first
      expect(job[:params]).to eq({ "job_name" => "weekly_job" })
      expect(job[:time_zone]).to eq("Asia/Tokyo")
      expect(job[:description]).to eq("Runs every week at 9:00 a.m. Created:2023/04/01 10:00")
      expect(job[:http_headers]).to eq("Authorization" => "Bearer secret_key", "Content-Type" => "application/json")
      expect(job[:http_method]).to eq("POST")
      expect(job[:name]).to eq("WeeklyJob")
      expect(job[:schedule]).to eq("0 9 * * *")
      expect(job[:uri]).to eq("https://yourdomain.example.com/api/v1/jobs")
    end
  end

  describe "#scheduler_config_jobs" do
    before do
      travel_to Time.parse("2023/4/1 11:00")
      ENV["SECRET"] = "secret_key"
    end

    after do
      travel_back
    end

    it "Configuration file with default settings" do
      path = fixture_path("scheduler_with_defaults.yml")
      jobs = GcpScheduler::Scheduler.scheduler_config_jobs(file_path:       path,
                                                           job_name_prefix: "rspec-")

      expect(jobs.size).to eq(2)
      weekly_job = jobs.first
      expect(weekly_job[:name]).to eq("rspec-WeeklyJob")
      expect(weekly_job[:params]).to eq({ "job_name" => "weekly_job" })
      expect(weekly_job[:description]).to eq("Runs every week at 9:00 a.m. Created:2023/04/01 11:00")
      expect(weekly_job[:schedule]).to eq("0 9 * * *")

      daily_job = jobs.last
      expect(daily_job[:name]).to eq("rspec-DailyJob")
      expect(daily_job[:params]).to eq({ "job_name" => "daily_job" })
      expect(daily_job[:description]).to eq("Runs every day at 10:30 a.m. Created:2023/04/01 11:00")
      expect(daily_job[:schedule]).to eq("30 10 * * *")

      # defaults
      jobs.each do |job|
        expect(job[:uri]).to eq("https://yourdomain.example.com/api/v1/jobs")
        expect(job[:http_method]).to eq("POST")
        expect(job[:time_zone]).to eq("Asia/Tokyo")
        http_headers = { "Authorization" => "Bearer secret_key", "Content-Type" => "application/json" }
        expect(job[:http_headers]).to eq(http_headers)
      end
    end

    it "Configuration file without default settings" do
      path = fixture_path("scheduler.yml")
      jobs = GcpScheduler::Scheduler.scheduler_config_jobs(file_path:       path,
                                                           job_name_prefix: "rspec-")

      expect(jobs.size).to eq(1)
      job = jobs.first
      expect(job[:name]).to eq("rspec-WeeklyJob")
      expect(job[:description]).to eq("Runs every week at 9:00 a.m. Created:2023/04/01 11:00")
      expect(job[:schedule]).to eq("0 9 * * *")
      expect(job[:time_zone]).to eq("Asia/Tokyo")
      expect(job[:uri]).to eq("https://yourdomain.example.com/api/v1/jobs")
      expect(job[:http_method]).to eq("POST")
      expect(job[:params]).to eq({ "job_name" => "weekly_job" })
      expect(job[:http_headers]).to eq("Authorization" => "Bearer secret_key", "Content-Type" => "application/json")
    end
  end
end
