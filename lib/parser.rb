# frozen_string_literal: true

# This class parses the user input.
#
class Parser
  PLACE    = 'PLACE'
  MOVE     = 'MOVE'
  LEFT     = 'LEFT'
  RIGHT    = 'RIGHT'
  REPORT   = 'REPORT'
  EXIT     = 'EXIT'
  COMMANDS = [PLACE, MOVE, LEFT, RIGHT, REPORT].freeze

  EXIT_REGEX = /\A(q|quit|exit)\z/.freeze
  INVALID_COMMAND_MESSAGE = 'Command: invalid!'

  def self.command
    cmd = read_command

    case cmd
    when /\A(PLACE (-?)\d,(-?)\d,\w+)\z/
      cmd
    when /\A(MOVE)\z/
      MOVE
    when /\A(LEFT)\z/
      LEFT
    when /\A(RIGHT)\z/
      RIGHT
    when /\A(REPORT)\z/
      REPORT
    when EXIT_REGEX
      EXIT
    else
      $stdout.puts INVALID_COMMAND_MESSAGE
      nil
    end
  end

  def self.read_command
    input = $stdin.gets&.chomp.to_s
    return nil unless COMMANDS.include?(input) ||
                      input.match(PLACE) ||
                      input.match(EXIT_REGEX)

    input
  end
end
