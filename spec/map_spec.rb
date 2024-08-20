# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/map'
require_relative '../lib/position'

RSpec.describe Map do
  let(:instance) { described_class.new(5, 5, obstacles) }
  let(:obstacles) { [] }

  describe '#initialize' do
    context 'size exceeds' do
      it 'raises error' do
        expect do
          described_class.new(Map::MAP_MAX_WIDTH + 1, Map::MAP_MAX_HEIGHT + 1)
        end.to raise_error(MapSetupError, 'Map size exceeds max (10_000)')
      end
    end
  end

  describe '#valid_move?' do
    it 'returns true' do
      expect(instance.valid_move?(Position.new(0, 0, Position::NORTH))).to eq(true)
    end

    it 'returns false - coordination' do
      expect(instance.valid_move?(Position.new(-1, 0, Position::NORTH))).to eq(false)
    end

    it 'returns false - direction' do
      expect(instance.valid_move?(Position.new(-1, 0, 'INVALID'))).to eq(false)
    end
  end

  describe '#hit_obstacle?' do
    context 'without obstacles' do
      it 'return false - case 1' do
        expect(instance.hit_obstacle?(Position.new(0, 0, Position::NORTH))).to eq(false)
      end

      it 'return false - case 2' do
        expect(instance.hit_obstacle?(Position.new(4, 4, Position::SOUTH))).to eq(false)
      end
    end

    context 'with obstacles' do
      let(:obstacles) { [[0, 0], [4, 4]] }

      it 'case 1: return true' do
        expect(instance.hit_obstacle?(Position.new(0, 0, Position::NORTH))).to eq(true)
      end

      it 'case 2: return true' do
        expect(instance.hit_obstacle?(Position.new(4, 4, Position::NORTH))).to eq(true)
      end

      it 'case 3: return false' do
        expect(instance.hit_obstacle?(Position.new(1, 2, Position::NORTH))).to eq(false)
      end
    end
  end
end
