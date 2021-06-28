class SimpleProcessManager
  def initialize(process:, logger:, interval:)
    @process = process
    @logger = logger
    @interval = interval
  end

  def start
    if status == :running
      logger.info('already running')
      return
    end

    @status = :running
    logger.info('started')

    begin
      @thread = Thread.new do
        while status == :running
          process.call
          sleep(interval)
        end
      end
    rescue => e
      logger.error('error: ' + e.message)
      @status = :stopped
    end
  end

  def stop
    @status = :stopped
    logger.info('stopped')
    Thread.kill(@thread) if @thread.alive?
  end

  private

  attr_reader :process,
              :logger,
              :interval,
              :status
end