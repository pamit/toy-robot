# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/map'
require_relative '../lib/position'

RSpec.describe Map do
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
    let(:instance) { described_class.new }

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
end
