# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/commands/place_command'
require_relative '../../lib/robot'
require_relative '../../lib/map'
require_relative '../../lib/position'

RSpec.describe PlaceCommand do
  let(:robot) { Robot.new }
  let(:obstacles) { [] }
  let(:map) { Map.new(5, 5, obstacles) }
  let(:position) { Position.new }
  let(:instance) { described_class.new(map:, robot:, position:) }

  describe 'execute' do
    context 'invalid coordinations - initial' do
      it do
        expect { instance.execute }.to raise_error(MapSetupError, /Wrong coordination/)
      end
    end

    context 'invalid coordinations - new position' do
      let(:position) { Position.new(100, 100) }

      it do
        expect { instance.execute }.to raise_error(MapSetupError, /Wrong coordination/)
      end
    end

    context 'robot placed' do
      let(:position) { Position.new(0, 0, Position::NORTH) }

      it do
        instance.execute
        expect(robot.report).to eq('0,0,NORTH')
      end
    end

    context 'with obstacles' do
      let(:obstacles) { [[0, 0], [4, 4]] }
      let(:position) { Position.new(0, 0, Position::NORTH) }

      it 'returns an error if there is an obstacle' do
        expect { instance.execute }.to raise_error(MapSetupError, /Wrong coordination/)
      end
    end
  end
end
