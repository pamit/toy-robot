# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/commands/turn_right_command'
require_relative '../../lib/robot'
require_relative '../../lib/map'

RSpec.describe TurnRightCommand do
  let(:robot) { Robot.new }
  let(:map) { Map.new }
  let(:instance) { described_class.new(map:, robot:) }

  describe 'execute' do
    context 'robot not placed yet' do
      it do
        expect { instance.execute }.to raise_error(InvalidMoveError, /Robot is not placed yet/)
      end
    end

    context 'robot placed' do
      let(:position) { Position.new(0, 0, Position::NORTH) }

      it do
        robot.place(position)
        instance.execute
        expect(robot.report).to eq('0,0,EAST')
      end
    end
  end
end
