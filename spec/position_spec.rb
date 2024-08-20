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

  describe '#to_point' do
    before do
      instance.place(x: 2, y: 3, direction: Position::NORTH)
    end

    it { expect(instance.to_point).to eq([2, 3]) }
  end

  describe '#==' do
    before do
      instance.place(x: 2, y: 3, direction: Position::NORTH)
    end

    it { expect(instance).to eq(Position.new(2, 3)) }
  end
end
