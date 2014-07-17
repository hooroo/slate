# encoding: utf-8

require 'slate/request_id_holder'

module Slate
  module Metrics
    class TimedResult

      def self.time(logger, formatter, event_name, log_data = {})
        start_time = Time.now
        yield
      ensure

        request_id = RequestIdHolder.request_id

        log_entry = {
          event_name: event_name,
          timing: millis_since(start_time)
        }

        log_entry.merge!(log_data)
        log_entry.merge!(request_id: request_id) if request_id

        logger.info(formatter.format(log_entry))

      end

      def self.millis_since(start_time)
        (Time.now - start_time) * 1000
      end

    end
  end
end