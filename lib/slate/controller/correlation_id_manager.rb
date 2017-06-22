# Mix into rails controller to have a correlation id set into a thread local for reference in log entries
# Uses the X-Correlation-Id header if present or generates a new Id

require 'slate/correlation_id_holder'

module Slate
  module Controller
    module CorrelationIdManager
      def self.included(base)
        if base.respond_to?(:before_action)
          base.before_action :set_correlation_id
        else
          base.before_filter :set_correlation_id
        end
      end

      def set_correlation_id
        CorrelationIdHolder.correlation_id = correlation_id
      end

      private

      def correlation_id
        request.headers['X-Correlation-Id'] || SecureRandom.uuid
      end

    end
  end
end
