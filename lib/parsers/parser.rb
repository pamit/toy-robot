# frozen_string_literal: true

require_relative '../position'
require_relative '../commands/exit_command'
require_relative '../commands/move_command'
require_relative '../commands/noop_command'
require_relative '../commands/place_command'
require_relative '../commands/report_command'
require_relative '../commands/turn_left_command'
require_relative '../commands/turn_right_command'
require_relative '../commands/path_command'
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
  PATH_REGEX   = /\A(PATH (-?)\d+,\s*(-?)\d+)\z/

  attr_reader :map, :robot

  def initialize(map, robot)
    @map = map
    @robot = robot
  end

  def command
    raise MethodNotImplementedError, "Method #{__method__} not implemented in #{self.class}"
  end

  def extract_command(input) # rubocop:disable Metrics/AbcSize
    case input
    when PLACE_REGEX
      args = input.split(/PLACE\s*/)[1].split(/,\s*/)
      position = Position.new(args[0].to_i, args[1].to_i, args[2])
      PlaceCommand.new(map: @map, robot: @robot, position:)
    when MOVE_REGEX
      MoveCommand.new(map:, robot:)
    when LEFT_REGEX
      TurnLeftCommand.new(robot:)
    when RIGHT_REGEX
      TurnRightCommand.new(robot:)
    when REPORT_REGEX
      ReportCommand.new(robot:)
    when PATH_REGEX
      args = input.split(/PATH\s*/)[1].split(/,\s*/)
      destination = Position.new(args[0].to_i, args[1].to_i)
      PathCommand.new(map:, robot:, destination:)
    when EXIT_REGEX
      ExitCommand.new
    else
      NoopCommand.new
    end
  end
end
