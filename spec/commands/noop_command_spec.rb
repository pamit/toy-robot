# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/commands/noop_command'

RSpec.describe NoopCommand do
  let(:instance) { described_class.new }

  describe 'execute' do
    context 'outputs to stdout' do
      it do
        expect { instance.execute }.to output(/Invalid command!/).to_stdout
      end
    end
  end
end
