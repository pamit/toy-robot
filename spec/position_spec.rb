# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/position'
require_relative '../lib/map'

RSpec.describe Position do
  let(:instance) { described_class.new }

  describe '#initialize' do
    it 'sets the coordination to nil' do
      expect(instance.x).to eq(nil)
      expect(instance.y).to eq(nil)
    end
  end

  describe '#place' do
    it 'sets the coordination' do
      instance.place(x: 0, y: 0, direction: Position::NORTH)
      expect(instance.x).to eq(0)
      expect(instance.y).to eq(0)
      expect(instance.direction).to eq(Position::NORTH)
    end

    it 'raises if direction is invalid' do
      expect { instance.place(x: 0, y: 0, direction: 'INVALID') }.to raise_error(MapSetupError)
    end
  end

  describe '#next_move' do
    before do
      instance.place(x: 0, y: 0, direction: Position::NORTH)
    end

    it 'updates direction to EAST' do
      expect(instance.next_move.x).to eq(0)
      expect(instance.next_move.y).to eq(1)
    end
  end

  describe '#turn_right' do
    before do
      instance.place(x: 0, y: 0, direction: Position::NORTH)
      instance.turn_right
    end

    it 'updates direction to EAST' do
      expect(instance.direction).to eq(Position::EAST)
    end
  end

  describe '#turn_left' do
    before do
      instance.place(x: 0, y: 0, direction: Position::NORTH)
      instance.turn_left
    end

    it 'updates direction to WEST' do
      expect(instance.direction).to eq(Position::WEST)
    end
  end

  # describe '#move' do
  #   context 'when robot is not placed yet' do
  #     it 'does not change the state' do
  #       expect { instance.move }.to raise_error(InvalidMoveError, /Robot is not placed yet!/)

  #       expect(instance.x).to eq(-1)
  #       expect(instance.y).to eq(-1)
  #       expect(instance.direction).to eq(nil)
  #     end
  #   end

  #   context 'when robot may fall' do
  #     it 'case 1' do
  #       instance.place(x: 1, y: 4, direction: Map::NORTH)
  #       expect { instance.move }.to raise_error(InvalidMoveError, /Robot may fall!/)

  #       expect(instance.x).to eq(1)
  #       expect(instance.y).to eq(4)
  #       expect(instance.direction).to eq(Map::NORTH)
  #     end

  #     it 'case 2' do
  #       instance.place(x: 3, y: 0, direction: Map::SOUTH)
  #       expect { instance.move }.to raise_error(InvalidMoveError, /Robot may fall!/)

  #       expect(instance.x).to eq(3)
  #       expect(instance.y).to eq(0)
  #       expect(instance.direction).to eq(Map::SOUTH)
  #     end
  #   end

  #   context 'with valid move' do
  #     it 'case 1' do
  #       instance.place(x: 1, y: 1, direction: Map::NORTH)
  #       instance.move

  #       expect(instance.x).to eq(1)
  #       expect(instance.y).to eq(2)
  #       expect(instance.direction).to eq(Map::NORTH)
  #     end

  #     it 'case 2' do
  #       instance.place(x: 2, y: 3, direction: Map::WEST)
  #       instance.move

  #       expect(instance.x).to eq(1)
  #       expect(instance.y).to eq(3)
  #       expect(instance.direction).to eq(Map::WEST)
  #     end
  #   end

  #   context 'random setup' do
  #     let(:x)    { rand(-10..10) }
  #     let(:y)    { rand(-10..10) }
  #     let(:direction) { Map::DIRECTIONS.sample }
  #     let(:turn) { %i[right left].sample }

  #     it 'we trust you buddy!' do
  #       if (x < 0 || x > Map::MAP_DEFAULT_WIDTH) || (y < 0 || y > Map::MAP_DEFAULT_HEIGHT)
  #         expect { instance.place(x:, y:, direction:) }.to raise_error(MapSetupError)
  #       else
  #         instance.place(x:, y:, direction:)
  #         instance.send("turn_#{turn}")

  #         if x == Map::MAP_DEFAULT_WIDTH - 1 || y == Map::MAP_DEFAULT_HEIGHT - 1
  #           expect { instance.move }.to raise_error(InvalidMoveError)
  #         else
  #           instance.move
  #         end
  #       end
  #     end
  #   end
  # end
end
