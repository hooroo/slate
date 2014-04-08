# encoding: utf-8
require 'slate/metrics/timed_result'

module Slate
  module Metrics

    def self.time(event_name, data = {}, &block)
      TimedResult.time(logger, formatter, event_name, data) { yield }
    end

    # def self.incr(key, size)

    # end

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