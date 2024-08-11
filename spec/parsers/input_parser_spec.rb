# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/parsers/input_parser'
require_relative '../../lib/map'
require_relative '../../lib/robot'

RSpec.describe InputParser do
  let(:robot) { Robot.new }
  let(:map) { Map.new }
  let(:instance) { described_class.new(map, robot) }

  describe '#extract_command' do
    {
      NoopCommand: 'INVALID',
      PlaceCommand: 'PLACE 0,0,NORTH',
      MoveCommand: 'MOVE',
      TurnLeftCommand: 'LEFT',
      TurnRightCommand: 'RIGHT',
      ReportCommand: 'REPORT',
      ExitCommand: 'EXIT'
    }.each do |command, request|
      it "returns #{command}" do
        $stdin = StringIO.new(request)
        expect(instance.extract_command(request).class.to_s).to eq(command.to_s)
      end
    end
  end
end
