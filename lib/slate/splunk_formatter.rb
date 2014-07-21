#encoding: utf-8

module Slate
  module SplunkFormatter
    def self.format(entry)
      entry.inject [] do |result, entry|
        result << "#{entry[0]}=#{entry[1].to_s.inspect}"
      end.join(", ")
    end
  end
end