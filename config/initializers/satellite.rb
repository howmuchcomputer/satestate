require 'simple_process_manager'

Satellite.configure do |config|
  # configure API here
end

SATELLITE_API = Satellite::API.new(
    logger: Rails.logger
)

satellite_process = SimpleProcessManager.new(
    process: Proc.new { SATELLITE_API.update },
    logger: Rails.logger,
    interval: 10 # seconds
)

satellite_process.start