#encoding: utf-8

require 'spec_helper'
require 'slate/splunk_formatter'

module Slate
  describe SplunkFormatter do
    describe '.format' do
      let(:entry) do
        {
          key1: 'value1',
          key2: 'value2'
        }
      end
      context 'when there is a simple value' do
        it 'formats with quoted values' do
          expect(described_class.format(entry)).to eq('key1="value1", key2="value2"')
        end
      end

      context 'when there is a value containing quotes' do
        let(:entry) do
          {
            key1: 'value1 "value2"',
            key2: 'value2 '
          }
        end
        it 'escapes quotes inside quoted values' do
          expect(described_class.format(entry)).to eq('key1="value1 \"value2\"", key2="value2 "')
        end
      end

      context 'when the value is nil' do
        let(:entry) do
          {
            key1: '',
            key2: nil
          }
        end

        it 'does not add quotes' do
          expect(described_class.format(entry)).to eq("key1=\"\", key2=")
        end
      end

      context 'when the value is boolean' do
        let(:entry) do
          {
            key1: true,
            key2: false
          }
        end

        it 'does not add quotes' do
          expect(described_class.format(entry)).to eq("key1=\"true\", key2=\"false\"")
        end
      end
    end
  end
end
