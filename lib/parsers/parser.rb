# frozen_string_literal: true

require_relative '../position'
require_relative '../commands/exit_command'
require_relative '../commands/move_command'
require_relative '../commands/noop_command'
require_relative '../commands/place_command'
require_relative '../commands/report_command'
require_relative '../commands/turn_left_command'
require_relative '../commands/turn_right_command'
# Dir.glob("#{File.dirname(__FILE__)}/lib/commands/*.rb").each { |file| require_relative file }

# This class parses the user input.
#
class Parser
  PLACE_REGEX  = /\A(PLACE (-?)\d+,\s*(-?)\d+,\s*\w+)\z/
  EXIT_REGEX   = /\A(Q|QUIT|EXIT)\z/
  MOVE_REGEX   = /\A(MOVE)\z/
  LEFT_REGEX   = /\A(LEFT)\z/
  RIGHT_REGEX  = /\A(RIGHT)\z/
  REPORT_REGEX = /\A(REPORT)\z/

  attr_reader :map, :robot

  def initialize(map, robot)
    @map = map
    @robot = robot
  end

  def parse
    raise MethodNotImplementedError, "Method #{__method__} not implemented in #{self.class}"
  end
end
