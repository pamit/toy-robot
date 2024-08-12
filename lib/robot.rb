# frozen_string_literal: true

require_relative 'exceptions'

class Robot
  attr_reader :position

  def initialize(position = nil)
    @position = position || Position.new
  end

  def place(position)
    @position.place(x: position.x, y: position.y, direction: position.direction)
  end

  def move(position)
    raise InvalidMoveError, 'Robot is not placed yet!' unless placed?

    @position = position
  end

  def turn_right
    raise InvalidMoveError, 'Robot is not placed yet!' unless placed?

    @position.turn_right
  end

  def turn_left
    raise InvalidMoveError, 'Robot is not placed yet!' unless placed?

    @position.turn_left
  end

  def report
    raise MapSetupError, 'Robot is not placed yet!' unless placed?

    "#{@position.x},#{@position.y},#{@position.direction}"
  end

  def placed?
    !@position.nil? && @position.placed?
  end
end
