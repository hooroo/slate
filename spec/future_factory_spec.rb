# encoding: utf-8

require 'slate/future_factory'

module Slate
  describe FutureFactory do

    include FutureFactory

    describe "future creation" do

      let(:request_id) { 'abc-123' }

      it "creates a future" do
        future = traceable_future {}
        expect(future).to be_kind_of Celluloid::Future
      end

      it "passes request id into future thread" do

        Thread.current[:request_id] = request_id

        future = traceable_future do
          expect(Thread.current[:request_id]).to eq request_id
        end

        future.value

      end

    end
  end
end
