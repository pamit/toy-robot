# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/parsers/file_parser'
require_relative '../../lib/map'
require_relative '../../lib/robot'

RSpec.describe FileParser do
  let(:robot) { Robot.new }
  let(:map) { Map.new }
  let(:file) { 'test.txt' }
  let(:instance) { described_class.new(map, robot, file) }

  describe '#command' do
    context 'with sample test.txt' do
      it 'outputs to stdout' do
        expect { instance.command }.to output(/>>> Current position: 0,1,NORTH/).to_stdout
        expect { instance.command }.to output(/>>> Current position: 0,0,WEST/).to_stdout
        expect { instance.command }.to output(/>>> Current position: 3,3,NORTH/).to_stdout
      end
    end
  end
end
