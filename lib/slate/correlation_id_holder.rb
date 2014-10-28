# encoding: utf-8
module Slate
  module CorrelationIdHolder

    def self.correlation_id=(correlation_id)
      Thread.current[:correlation_id] = correlation_id || SecureRandom.uuid
    end

    def self.correlation_id
      Thread.current[:correlation_id]
    end

  end
end