#encoding: utf-8

require 'slate/request_id_holder'

module Slate
  module LogEntryDecorator
    def self.decorate(log_entry)
      {request_id: RequestIdHolder.request_id}.merge(hashify(log_entry))
    end

    def self.hashify(log_entry)
      if log_entry.kind_of?(Hash)
        log_entry
      else
        {message: log_entry}
      end
    end
  end
end