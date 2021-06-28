module State
  class Base
    def initialize(repository)
      @repository = repository
      @initialized_at = DateTime.now
    end

    def stats
      sample_data = repository.last(stats_sample_size)

      {
          minimum: sample_data.min,
          maximum: sample_data.max,
          average: sample_data.average
      }
    end

    def health
      raise NotImplementedError.new
    end

    private

    attr_reader :repository,
                :initialized_at

    def seconds_in_current_state
      ((DateTime.now - initialized_at) * 24 * 60 * 60).to_i
    end

    def altitude_stable?
      (repository.last(health_sample_size).sum(0.0) / health_sample_size) > altitude_stability
    end

    def health_sample_size
      Satellite.config.health_sample_size
    end

    def stats_sample_size
      Satellite.config.stats_sample_size
    end

    def altitude_stability
      Satellite.config.altitude_stability
    end

    def health_status
      Satellite.config.health_status
    end

    def seconds_for_recovery
      Satellite.config.seconds_for_recovery
    end
  end

  class Stable < Base
    def transition
      return Unstable.new(repository) unless altitude_stable?
      self
    end

    def health
      health_status[:stable]
    end
  end

  class Unstable < Base
    def transition
      return Recovered.new(repository) if altitude_stable?
      self
    end

    def health
      health_status[:unstable]
    end
  end

  class Recovered < Base
    def transition
      return self unless seconds_in_current_state >= seconds_for_recovery
      return Stable.new(repository) if altitude_stable?
      Unstable.new(repository)
    end

    def health
      health_status[:recovered]
    end
  end

  class Initial < Base
    def transition
      return self unless repository.size >= health_sample_size
      return Stable.new(repository) if altitude_stable?
      Unstable.new(repository)
    end

    def health
      health_status[:stable]
    end
  end
end