require 'json'

module Slate
  module Formatter
    module JSON
      def self.format(entry)
        { _time: Time.now.iso8601 }.merge(entry).to_json
      end
    end
  end
end
