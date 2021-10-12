# frozen_string_literal: true

require_relative 'errors'

# This class tracks the movement of the robot.
#
class Map
  NORTH = 'NORTH'
  EAST  = 'EAST'
  WEST  = 'WEST'
  SOUTH = 'SOUTH'

  DIRECTIONS = [NORTH, EAST, WEST, SOUTH].freeze

  MAX_X = 5
  MAX_Y = 5

  attr_reader :x, :y, :direction

  def initialize
    @x = -1
    @y = -1
    @direction = nil
  end

  def place(x:, y:, direction:) # rubocop:disable Naming/MethodParameterName
    set_initial_coordination(x, y)
    set_direction(direction)
  end

  def turn_right
    raise InvalidMoveError, 'Robot is not placed yet!' unless robot_is_placed?

    new_direction = nil

    case @direction
    when NORTH
      new_direction = EAST
    when EAST
      new_direction = SOUTH
    when WEST
      new_direction = NORTH
    when SOUTH
      new_direction = WEST
    end

    set_direction(new_direction)
  end

  def turn_left
    raise InvalidMoveError, 'Robot is not placed yet!' unless robot_is_placed?

    new_direction = nil

    case @direction
    when NORTH
      new_direction = WEST
    when EAST
      new_direction = NORTH
    when WEST
      new_direction = SOUTH
    when SOUTH
      new_direction = EAST
    end

    set_direction(new_direction)
  end

  def move
    raise InvalidMoveError, 'Robot is not placed yet!' unless robot_is_placed?

    next_x, next_y = possible_move
    raise InvalidMoveError, 'Robot may fall!' unless valid_move?(next_x, next_y)

    @x = next_x
    @y = next_y
  end

  def report
    raise InvalidMoveError, 'Robot is not placed yet!' unless robot_is_placed?

    "#{@x},#{@y},#{@direction}"
  end

  def robot_is_placed?
    @x != -1 && @y != -1
  end

  private

  def set_initial_coordination(x, y) # rubocop:disable Naming/MethodParameterName
    raise MapSetupError, 'Wrong coordination(s)' unless valid_move?(x, y)

    @x = x
    @y = y
  end

  def set_direction(direction)
    raise MapSetupError, 'Wrong direction' unless DIRECTIONS.include?(direction)

    @direction = direction
  end

  def possible_move
    next_x = @x
    next_y = @y

    case @direction
    when NORTH
      next_y += 1
    when EAST
      next_x += 1
    when WEST
      next_x -= 1
    when SOUTH
      next_y -= 1
    end

    [next_x, next_y]
  end

  def valid_move?(x, y) # rubocop:disable Naming/MethodParameterName
    (0..MAX_X).include?(x) && (0..MAX_Y).include?(y)
  end
end
