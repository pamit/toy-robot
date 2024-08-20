# frozen_string_literal: true

require_relative 'command'

class MoveCommand < Command
  def initialize(map: nil, robot: nil, position: nil)
    super(map:, robot:)
    @position = position
  end

  def execute
    raise MapSetupError, 'Robot is not placed yet!' unless @robot.placed?

    new_position = @robot.position.next_move
    raise MapSetupError, 'Robot may fall!' unless @map.valid_move?(new_position)
    raise MapSetupError, 'Robot may hit an obstacle!' if @map.hit_obstacle?(new_position)

    @robot.move(new_position)
  end
end
