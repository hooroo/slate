# encoding: utf-8

require 'slate/request_id_holder'

module Slate
  module Metrics
    class TimedResult

      def self.time(logger, event_name)
        start_time = Time.now
        yield
      ensure
        logger.call(
          event_name: event_name,
          timing: millis_since(start_time)
        )
      end

      def self.millis_since(start_time)
        (Time.now - start_time) * 1000
      end

    end
  end
end