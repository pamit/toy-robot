# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/commands/report_command'
require_relative '../../lib/robot'
require_relative '../../lib/map'
require_relative '../../lib/position'

RSpec.describe ReportCommand do
  let(:robot) { Robot.new }
  let(:map) { Map.new }
  let(:instance) { described_class.new(map:, robot:) }

  describe 'execute' do
    context 'robot not placed' do
      it do
        expect { instance.execute }.to raise_error(MapSetupError, /Robot is not placed yet!/)
      end
    end

    context 'robot placed' do
      let(:position) { Position.new(0, 0, Position::NORTH) }

      it do
        robot.place(position)
        instance.execute
        expect(robot.report).to eq('0,0,NORTH')
      end
    end
  end
end
