require 'celluloid'

module Slate
  module FutureFactory

    def traceable_future(&block)

      request_id = Thread.current[:request_id]

      Celluloid::Future.new do
        Thread.current[:request_id] = request_id
        yield
      end

    end
  end
end
