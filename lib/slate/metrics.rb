require 'slate/metrics/timed_result'

module Slate
  module Metrics

    def self.time(event_name, data = {}, &block)
      TimedResult.time(log_with(data), event_name) { yield }
    end

    def self.log_with(log_data)
      Proc.new do |log_entry|
        log_entry = log_entry.merge(log_data)
        @logger.info(@formatter.format(@decorator.decorate(log_entry)))
      end
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
