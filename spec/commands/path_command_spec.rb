# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/commands/path_command'
require_relative '../../lib/robot'
require_relative '../../lib/map'
require_relative '../../lib/position'

RSpec.describe PathCommand do
  let(:robot) { Robot.new }
  let(:obstacles) { [] }
  let(:map) { Map.new(3, 3, obstacles) }
  let(:position) { Position.new }
  let(:destination) { Position.new(2, 2) }
  let(:instance) { described_class.new(map:, robot:, destination:) }

  describe 'execute' do
    context 'robot not placed yet' do
      it do
        expect { instance.execute }.to raise_error(MapSetupError, /Robot is not placed yet!/)
      end
    end

    context 'without obstacles' do
      let(:position) { Position.new(0, 0, Position::NORTH) }

      it do
        robot.place(position)
        expected_output = ">>> Path to (#{destination.to_point}) is: [[0, 0], [1, 0], [2, 0], [2, 1], [2, 2]]\n"
        expect { instance.execute }.to output(expected_output).to_stdout
      end
    end

    context 'with obstacles' do
      context 'case 1' do
        let(:obstacles) { [[1, 1]] }
        let(:position) { Position.new(0, 0, Position::NORTH) }

        it do
          robot.place(position)
          expected_output = ">>> Path to (#{destination.to_point}) is: [[0, 0], [1, 0], [2, 0], [2, 1], [2, 2]]\n"
          expect { instance.execute }.to output(expected_output).to_stdout
        end
      end

      context 'case 2' do
        let(:obstacles) { [[1, 1], [2, 1]] }
        let(:position) { Position.new(0, 0, Position::NORTH) }

        it do
          robot.place(position)
          expected_output = ">>> Path to (#{destination.to_point}) is: [[0, 0], [0, 1], [0, 2], [1, 2], [2, 2]]\n"
          expect { instance.execute }.to output(expected_output).to_stdout
        end
      end

      context 'case 3' do
        let(:obstacles) { [[0, 1], [1, 1], [2, 1]] }
        let(:position) { Position.new(0, 2, Position::NORTH) }

        it do
          robot.place(position)
          expected_output = ">>> Path to (#{destination.to_point}) is: [[0, 2], [1, 2], [2, 2]]\n"
          expect { instance.execute }.to output(expected_output).to_stdout
        end
      end

      context 'case 4 - no path found' do
        let(:obstacles) { [[0, 1], [1, 1], [2, 1]] }
        let(:position) { Position.new(0, 0, Position::NORTH) }

        it do
          robot.place(position)
          expected_output = ">>> No path to (#{destination.to_point}) found!\n"
          expect { instance.execute }.to output(expected_output).to_stdout
        end
      end
    end
  end
end
