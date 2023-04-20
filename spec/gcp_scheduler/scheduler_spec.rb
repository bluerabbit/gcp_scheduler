require "spec_helper"

describe GcpScheduler::Scheduler do
  describe "#scheduler_config" do
    it do
      path = fixture_path("scheduler.yml")
      config = GcpScheduler::Scheduler.scheduler_config(path)
      expect(config).to eq({ "weekly_job" => { "cron" => "0 9 * * 1" } })
    end
  end
end
