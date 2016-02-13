require 'spec_helper'
require 'celluloid'

module Slate
  describe FutureFactory do

    include FutureFactory

    describe 'future creation' do

      let(:request_id) { 'abc-123' }

      it 'creates a future' do
        future = traceable_future {}
        expect(future).to be_kind_of Celluloid::Future
      end

      it 'passes request id into future thread' do

        RequestIdHolder.request_id = request_id

        future = traceable_future do
          expect(RequestIdHolder.request_id).to eq request_id
        end

        future.value

      end

    end
  end
end
