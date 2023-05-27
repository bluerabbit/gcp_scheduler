$LOAD_PATH.push File.expand_path("lib", __dir__)

Gem::Specification.new do |s|
  s.name        = "gcp_scheduler"
  s.version     = "0.2.0"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Akira Kusumoto"]
  s.email       = ["akirakusumo10@gmail.com"]
  s.homepage    = "https://github.com/bluerabbit/gcp_scheduler"
  s.summary     = "A command-line interface for managing Google Cloud Scheduler jobs with ease"
  s.description = "GCP Scheduler is a Ruby gem that provides a simple command-line interface for managing Google Cloud Scheduler jobs. With this tool, you can create, list, and delete Cloud Scheduler jobs using intuitive commands. It streamlines job management tasks by allowing you to define job schedules in a YAML file."

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ["lib"]
  s.licenses      = ["MIT"]

  s.bindir      = "exe"
  s.executables = s.files.grep(%r{^exe/}) {|f| File.basename(f) }
  s.add_runtime_dependency "thor"

  s.add_dependency "activesupport"
  s.add_dependency "google-cloud-scheduler-v1", [">= 0.7.0"]
  s.add_development_dependency "pry-byebug"
  s.add_development_dependency "rspec", "~> 3.9"
  s.metadata["rubygems_mfa_required"] = "true"
end
