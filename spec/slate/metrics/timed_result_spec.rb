require 'slate/metrics/timed_result'

module Slate
  module Metrics
    describe TimedResult do

      describe '.time' do

        let(:logger) { double('logger') }
        let(:event_name) {'my_event'}
        let(:timing) {1000}

        it 'calls logger with timed event entry' do
          expect(TimedResult).to receive(:millis_since).and_return(timing)
          expect(logger).to receive(:call).with({event_name: event_name, timing: timing})
          TimedResult.time(logger, 'my_event') {  }
        end

      end

    end
  end
end
