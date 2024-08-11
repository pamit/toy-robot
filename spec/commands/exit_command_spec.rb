# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/commands/exit_command'

RSpec.describe ExitCommand do
  let(:instance) { described_class.new }

  describe 'execute' do
    context 'outputs to stdout' do
      it do
        expect { instance.execute }.to raise_error(SystemExit)
      end
    end
  end
end
