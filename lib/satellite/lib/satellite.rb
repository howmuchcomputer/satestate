require "satellite/version"
require "satellite/connection"
require "satellite/repository"
require "satellite/state"
require "satellite/loggers"
require "satellite/configuration"

module Satellite
  class API
    def initialize(
        initial_state_class: State::Initial,
        repository: Repository::InMemoryRepository.new,
        logger: Loggers::StdOut.new)
      @state = initial_state_class.new(repository)
      @logger = logger
      @repository = repository
    end

    def stats
      state.stats
    end

    def health
      state.health
    end

    def update
      logger.info('updating satellite repository')
      repository << connection.fetch_data[data_key]
      @state = state.transition
    end

    private

    attr_reader :state,
                :logger,
                :repository

    def connection
      @connection ||= Connection.new(url)
    end

    def data_key
      Satellite.config.data_key
    end

    def url
      Satellite.config.url
    end
  end

  class << self
    attr_writer :configuration
  end

  def self.config
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(config)
  end
end
