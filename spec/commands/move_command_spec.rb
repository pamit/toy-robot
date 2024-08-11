# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/commands/move_command'
require_relative '../../lib/robot'
require_relative '../../lib/map'
require_relative '../../lib/position'

RSpec.describe MoveCommand do # rubocop:disable Metrics/BlockLength
  let(:robot) { Robot.new }
  let(:map) { Map.new }
  let(:position) { Position.new }
  let(:instance) { described_class.new(map:, robot:, position:) }

  describe 'execute' do
    context 'robot not placed yet' do
      it do
        expect { instance.execute }.to raise_error(MapSetupError, /Robot is not placed yet!/)
      end
    end

    context 'robot placed but may fall' do
      let(:position) { Position.new(0, 0, Position::WEST) }

      it do
        robot.place(position)
        expect { instance.execute }.to raise_error(MapSetupError, /Robot may fall!/)
      end
    end

    context 'robot placed' do
      let(:position) { Position.new(0, 0, Position::NORTH) }

      it do
        robot.place(position)
        instance.execute
        expect(robot.report).to eq('0,1,NORTH')
      end
    end
  end
end
