module Slate
  class Logger

    def initialize(logger: Log4r::Logger['default'], formatter: Formatter::JSON, decorator: Slate::LogEntryDecorator)
      @logger = logger
      @formatter = formatter
      @decorator = decorator
    end

    def debug(log_entry)
      @logger.debug(decorate_log_entry(log_entry))
    end

    def info(log_entry)
      @logger.info(decorate_log_entry(log_entry))
    end

    def warn(log_entry)
      @logger.warn(decorate_log_entry(log_entry))
    end

    def error(log_entry)
      @logger.error(decorate_log_entry(log_entry))
    end

    def fatal(log_entry)
      @logger.fatal(decorate_log_entry(log_entry))
    end

    def decorate_log_entry(log_entry)
      @formatter.format(@decorator.decorate(log_entry))
    end


    ## Maintain for backwards compatibility

    def self.debug(log_entry)
      @logger.debug(decorate_log_entry(log_entry))
    end

    def self.info(log_entry)
      @logger.info(decorate_log_entry(log_entry))
    end

    def self.warn(log_entry)
      @logger.warn(decorate_log_entry(log_entry))
    end

    def self.error(log_entry)
      @logger.error(decorate_log_entry(log_entry))
    end

    def self.fatal(log_entry)
      @logger.fatal(decorate_log_entry(log_entry))
    end

    def self.decorate_log_entry(log_entry)
      @formatter.format(@decorator.decorate(log_entry))
    end

    def self.logger=(logger)
      @logger = logger
    end

    def self.formatter=(formatter)
      @formatter = formatter
    end

    def self.decorator=(decorator)
      @decorator = decorator
    end

  end
end
