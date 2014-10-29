# encoding: utf-8
module Slate
  module RequestIdHolder

    def self.request_id=(request_id)
      Thread.current[:request_id] = request_id
    end

    def self.request_id
      Thread.current[:request_id]
    end

  end
end