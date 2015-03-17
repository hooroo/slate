require 'slate/request_id_holder'
require 'slate/correlation_id_holder'

module Slate
  module LogEntryDecorator
    # Strike 1: This is not a decorator. Confusing!
    def self.decorate(log_entry)
      hashed_log_entry = hashify(log_entry)
      hashed_log_entry[:request_id] = RequestIdHolder.request_id unless RequestIdHolder.request_id.to_s.empty?
      hashed_log_entry[:correlation_id] = CorrelationIdHolder.correlation_id unless CorrelationIdHolder.correlation_id.to_s.empty?

      hashed_log_entry
    end

    def self.hashify(log_entry)
      if log_entry.kind_of?(Hash)
        log_entry
      else
        { message: log_entry }
      end
    end
  end
end
