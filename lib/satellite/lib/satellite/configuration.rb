module Satellite
  class Configuration
    attr_accessor :url,
                  :data_key,
                  :health_sample_size,
                  :stats_sample_size,
                  :seconds_for_recovery,
                  :altitude_stability,
                  :health_status

    def initialize
      @url = 'http://nestio.space/api/satellite/data'
      @data_key = 'altitude'
      @health_sample_size = 60 / 10
      @stats_sample_size = 60 * 5 / 10
      @seconds_for_recovery = 60
      @altitude_stability = 160 # km
      @health_status = {
        stable: 'Altitude is A-OK',
        unstable: 'WARNING: RAPID ORBITAL DECAY IMMINENT',
        recovered: 'Sustained Low Earth Orbit Resumed'
      }
    end
  end
end