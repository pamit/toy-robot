# frozen_string_literal: true

require_relative 'command'

class TurnRightCommand < Command
  def execute
    @robot.turn_right
  end
end
