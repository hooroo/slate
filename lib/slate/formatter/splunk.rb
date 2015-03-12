module Slate
  module Formatter
    module Splunk
      def self.format(entry)
        entry.inject [] do |result, entry|
          value = entry[1]
          value_result = (value==nil) ? nil : value.to_s.inspect
          result << "#{entry[0]}=#{value_result}"
        end.join(', ')
      end
    end
  end
end
