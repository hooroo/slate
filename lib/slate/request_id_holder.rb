# encoding: utf-8
module Slate
  module RequestIdHolder

    def self.request_id=(new_request_id)
      Thread.current[:request_id] = new_request_id || SecureRandom.uuid
    end

    def self.request_id
      Thread.current[:request_id]
    end

  end
end