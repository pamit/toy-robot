# frozen_string_literal: true

require_relative 'parser'

# This class parses the user's input.
#
class InputParser < Parser
  def command
    loop do
      command = extract_command(fetch_input)
      command.execute
    rescue MapSetupError, InvalidMoveError, NotImplementedError => e
      # Log exceptions for monitoring
      $stdout.puts e.message
    end
  end

  def fetch_input
    $stdin.gets&.chomp.to_s.upcase
  end

  def extract_command(input) # rubocop:disable Metrics/AbcSize
    case input
    when PLACE_REGEX
      args = input.split(/PLACE\s*/)[1].split(/,\s*/)
      position = Position.new(args[0].to_i, args[1].to_i, args[2])
      PlaceCommand.new(map:, robot:, position:)
    when MOVE_REGEX
      MoveCommand.new(map:, robot:)
    when LEFT_REGEX
      TurnLeftCommand.new(robot:)
    when RIGHT_REGEX
      TurnRightCommand.new(robot:)
    when REPORT_REGEX
      ReportCommand.new(robot:)
    when EXIT_REGEX
      ExitCommand.new
    else
      NoopCommand.new
    end
  end
end
