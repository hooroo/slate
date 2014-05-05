require 'slate/metrics/timed_result'

module  Slate
  module Controller
    module ActionTimer

      include Metrics

      def time_action
        time('controller_request', { controller_name: controller_name, action_name: action_name, url: request.url } ) do
          yield
        end
      end

    end
  end
end