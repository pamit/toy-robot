# frozen_string_literal: true

require_relative 'command'

class PlaceCommand < Command
  def initialize(map: nil, robot: nil, position: nil)
    super(map:, robot:)
    @position = position
  end

  def execute
    raise MapSetupError, 'Wrong coordination(s)' unless @map.valid_move?(@position)

    @robot.place(@position)
  end
end
