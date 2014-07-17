# encoding: utf-8
require 'slate/metrics'

module Slate
  describe Metrics do

    describe '.time' do
      let(:event_name) {'an_event'}
      let(:logger) {double('logger')}
      let(:timed_event) {{event_name: event_name}}
      before do
        allow(Metrics).to receive(:log_with).and_return(logger)
      end
      it 'calls timed result' do
        expect(Metrics::TimedResult).to receive(:time).with(logger, event_name).and_yield
        Metrics.time(event_name, {}) {  }
      end
    end
  end
end
