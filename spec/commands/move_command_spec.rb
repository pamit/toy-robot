# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/commands/move_command'
require_relative '../../lib/robot'
require_relative '../../lib/map'
require_relative '../../lib/position'

RSpec.describe MoveCommand do
  let(:robot) { Robot.new }
  let(:obstacles) { [] }
  let(:map) { Map.new(5, 5, obstacles) }
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

    context 'with obstacles' do
      let(:obstacles) { [[0, 1], [4, 4]] }
      let(:position) { Position.new(0, 0, Position::NORTH) }

      it 'returns an error if there is an obstacle' do
        robot.place(position)
        expect { instance.execute }.to raise_error(MapSetupError, /Robot may fall!/)
      end
    end
  end
end
