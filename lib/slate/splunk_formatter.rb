#encoding: utf-8

module Slate
  module SplunkFormatter
    def self.format(entry)
      entry.inject [] do |result, entry|
        value = entry[1]
        value_result = value ? value.to_s.inspect : nil
        result << "#{entry[0]}=#{value_result}"
      end.join(", ")
    end
  end
end