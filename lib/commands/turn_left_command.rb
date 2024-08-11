# frozen_string_literal: true

require_relative 'command'

class TurnLeftCommand < Command
  def execute
    @robot.turn_left
  end
end
