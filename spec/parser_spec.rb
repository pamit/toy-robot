# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/parser'
require_relative '../lib/map'
require_relative '../lib/robot'

RSpec.describe Parser do
  let(:instance) { described_class }
  let(:robot) { Robot.new }
  let(:map) { Map.new }

  describe '.command' do
    {
      NoopCommand: "INVALID\n",
      PlaceCommand: "PLACE 0,0,NORTH\n",
      MoveCommand: "MOVE\n",
      TurnLeftCommand: "LEFT\n",
      TurnRightCommand: "RIGHT\n",
      ReportCommand: "REPORT\n",
      ExitCommand: "EXIT\n"
    }.each do |command, request|
      it "returns #{command}" do
        $stdin = StringIO.new(request)
        expect(instance.command(map, robot).class.to_s).to eq(command.to_s)
      end
    end
  end
end
