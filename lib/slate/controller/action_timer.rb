# require 'slate/metrics/timed_result'

module  Slate
  module Controller
    module ActionTimer

      def time_action
        Metrics.time('controller_request', { controller_name: controller_name, action_name: action_name, url: request.url } ) do
          yield
        end
      end

    end
  end
end