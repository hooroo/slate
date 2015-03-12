require 'spec_helper'
require 'slate/formatter/json'

module Slate
  module Formatter
    describe JSON do
      describe '.format' do
        let(:entry) { Hash[event_name: 'booya'] }

        subject { described_class.format(entry) }

        before(:each) do
          Timecop.freeze
        end

        it 'adds a timestamp' do
          expect(::JSON.parse(subject)).to include('timestamp' => Time.now.iso8601)
        end

        it 'returns the original hash' do
          expect(::JSON.parse(subject)).to include('event_name' => 'booya')
        end

        after do
          Timecop.return
        end
      end
    end
  end
end
