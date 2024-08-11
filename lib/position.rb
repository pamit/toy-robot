# frozen_string_literal: true

require_relative 'exceptions'

# This class tracks the movement of the robot.
#
class Position
  NORTH = 'NORTH'
  EAST  = 'EAST'
  WEST  = 'WEST'
  SOUTH = 'SOUTH'

  DIRECTIONS = [NORTH, EAST, SOUTH, WEST].freeze

  attr_reader :x, :y, :direction

  def initialize(x = nil, y = nil, direction = nil) # rubocop:disable Naming/MethodParameterName
    @x = x
    @y = y
    @direction = direction
  end

  def place(x:, y:, direction:) # rubocop:disable Naming/MethodParameterName
    raise MapSetupError, 'Wrong direction' unless DIRECTIONS.include?(direction)

    @x = x
    @y = y
    @direction = direction
  end

  def next_move
    case @direction
    when NORTH
      Position.new(@x, @y + 1, @direction)
    when EAST
      Position.new(@x + 1, @y, @direction)
    when WEST
      Position.new(@x - 1, @y, @direction)
    when SOUTH
      Position.new(@x, @y - 1, @direction)
    end
  end

  def turn_right
    @direction = DIRECTIONS[(DIRECTIONS.index(@direction) + 1) % DIRECTIONS.size]
  end

  def turn_left
    @direction = DIRECTIONS[(DIRECTIONS.index(@direction) - 1) % DIRECTIONS.size]
  end

  def placed?
    !@x.nil? && !@y.nil? && !@direction.nil?
  end
end
