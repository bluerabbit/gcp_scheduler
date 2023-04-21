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
end
