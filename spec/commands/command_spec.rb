# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/commands/command'

RSpec.describe Command do
  let(:instance) { described_class.new }

  describe 'execute' do
    context 'raises an exception' do
      it do
        expect { instance.execute }.to raise_error(MethodNotImplementedError)
      end
    end
  end
end
