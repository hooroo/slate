#encoding: utf-8

require 'slate/request_id_holder'

module Slate
  module FutureFactory

    def traceable_future(&block)

      request_id = RequestIdHolder.request_id

      Celluloid::Future.new do
        RequestIdHolder.request_id = request_id
        yield
      end

    end
  end
end
