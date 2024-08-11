# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/robot'
require_relative '../lib/map'
require_relative '../lib/position'

RSpec.describe Robot do
  describe '#placed?' do
    context 'with initial setup' do
      let(:instance) { described_class.new }

      it 'returns false' do
        expect(instance.placed?).to eq(false)
      end
    end

    context 'with a position' do
      let(:position) { Position.new(0, 0, Position::NORTH) }
      let(:instance) { described_class.new(position) }

      it 'returns true' do
        instance.move(position)
        expect(instance.placed?).to eq(true)
      end
    end
  end

  describe '#report' do
    context 'with initial setup' do
      let(:instance) { described_class.new }

      it 'raises if robot is not placed' do
        expect { instance.report }.to raise_error(MapSetupError)
      end
    end

    context 'with a position' do
      let(:position) { Position.new(0, 0, Position::NORTH) }
      let(:instance) { described_class.new(position) }

      it 'returns current position' do
        instance.move(position)
        expect(instance.report).to eq('0,0,NORTH')
      end
    end
  end
end
