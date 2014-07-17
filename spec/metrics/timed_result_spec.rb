# encoding: utf-8

require 'slate/metrics/timed_result'

module Slate
  module Metrics
    describe TimedResult do

      context 'without extra log data' do

        let(:request_id) { 'abc-123' }
        let(:logger) { double('logger') }
        let(:formatter) { double('formatter') }

        before do
          TimedResult.stub(:millis_since).and_return 1000
          Thread.current[:request_id] = request_id
        end

        it 'logs event with base data' do
          formatted_entry = "event_name='my_event', request_id='#{request_id}', timing='#{1000}'"
          formatter.should_receive(:format).with(event_name: 'my_event', request_id: request_id, timing: 1000).and_return formatted_entry
          logger.should_receive(:info).with(formatted_entry)
          TimedResult.time(logger, formatter, 'my_event') {  }
        end

        it 'logs event with extra data' do

          formatted_entry = "event_name='my_event', request_id='#{request_id}', timing='#{1000}'"
          formatter.should_receive(:format).with(event_name: 'my_event', request_id: request_id, timing: 1000, foo: 'bar').and_return formatted_entry
          logger.should_receive(:info).with(formatted_entry)

          TimedResult.time(logger, formatter, 'my_event', { foo: 'bar' }) {  }
        end

      end

    end
  end
end