# encoding: utf-8
module Slate
  module Logger

    def self.debug(log_entry)
      logger.debug(formatter.format(log_entry))
    end

    def self.info(log_entry)
      logger.info(formatter.format(log_entry))
    end

    def self.warn(log_entry)
      logger.warn(formatter.format(log_entry))
    end

    def self.error(log_entry)
      logger.error(formatter.format(log_entry))
    end

    def self.fatal(log_entry)
      logger.fatal(formatter.format(log_entry))
    end

    def self.logger
      @logger
    end

    def self.logger=(logger)
      @logger = logger
    end

    def self.formatter
      @formatter
    end

    def self.formatter=(formatter)
      @formatter = formatter
    end

  end
end
