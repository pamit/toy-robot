# frozen_string_literal: true

require_relative 'parser'

# This class parses the test data file.
#
class FileParser < Parser
  def initialize(map, robot, file)
    super(map, robot)
    @file = file
  end

  def command
    File.foreach(@file) do |next_line|
      line = next_line.chomp.strip.to_s.upcase
      $stdout.puts line
      next if line == '' || line.start_with?('#')

      command = extract_command(line)
      command.execute
    rescue MapSetupError, InvalidMoveError, NotImplementedError => e
      # Log exceptions for monitoring
      $stdout.puts e.message
    end
  end

  def extract_command(line) # rubocop:disable Metrics/AbcSize
    case line
    when PLACE_REGEX
      args = line.split(/PLACE\s*/)[1].split(/,\s*/)
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
