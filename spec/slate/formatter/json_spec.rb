require 'spec_helper'
require 'slate/formatter/json'

module Slate
  module Formatter
    describe JSON do
      describe '.format' do
        let(:entry) { Hash['event_name' => 'booya'] }

        subject(:json) { described_class.format(entry) }

        let(:parsed_json)  { ::JSON.parse(json) }

        before(:each) do
          Timecop.freeze
        end

        it 'adds a _time field to the result' do
          expect(parsed_json).to include('_time' => Time.now.iso8601)
        end

        it 'expects the _time field to be the first KV pair' do
          expect(parsed_json.first).to eq(['_time', Time.now.iso8601])
        end

        it 'returns the original hash' do
          expect(parsed_json).to include(entry)
        end

        after do
          Timecop.return
        end
      end
    end
  end
end
