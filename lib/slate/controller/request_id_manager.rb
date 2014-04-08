#Mix into rails controller to have the request id set into a thread local for reference in log entries
#Uses the rails X-Request-Id header if present or generates a new Id
module Slate
  module Controller
    module RequestIdManager

      def self.included(base)
        base.before_filter :set_request_id
      end

      def set_request_id
        Thread.current[:request_id] = request_id
      end

      private

      def request_id
        if request && request.uuid
          request.uuid
        else
          SecureRandom.uuid
        end
      end

    end
  end
end