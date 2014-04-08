module Slate
  module SplunkFormatter
    def self.format(entry)
      if entry.kind_of?(Hash)
        entry.inject [] do |result, entry|
          result << "#{entry[0]}=#{entry[1]}"
        end.join(", ")
      else
        entry.to_s
      end
    end
  end
end