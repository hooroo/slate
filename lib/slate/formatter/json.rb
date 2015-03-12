require 'json'

module Slate
  module Formatter
    module JSON
      def self.format(entry)
        entry.merge(timestamp: Time.now.iso8601).to_json
      end
    end
  end
end
