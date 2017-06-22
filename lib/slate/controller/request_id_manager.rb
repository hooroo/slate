# Mix into rails controller to have the request id set into a thread local for reference in log entries
# Uses the rails X-Request-Id header if present or generates a new Id

require 'slate/request_id_holder'

module Slate
  module Controller
    module RequestIdManager
      def self.included(base)
        if base.respond_to?(:before_action)
          base.before_action :set_request_id
        else
          base.before_filter :set_request_id
        end
      end

      def set_request_id
        RequestIdHolder.request_id = request_id
      end

      private

      def request_id
        request.uuid || SecureRandom.uuid
      end

    end
  end
end
