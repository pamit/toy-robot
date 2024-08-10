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

  EXIT_REGEX = /\A(q|Q|quit|QUIT|exit|EXIT)\z/
  INVALID_COMMAND_MESSAGE = 'Command: invalid!'

  (COMMANDS + [EXIT]).each do |command|
    define_singleton_method("#{command.downcase}?") do
      @cmd == command
    end
  end

  def self.command
    input = read_command

    case input
    when /\A(PLACE (-?)\d+,\s*(-?)\d+,\s*\w+)\z/
      @cmd = PLACE
      input
    when /\A(MOVE)\z/
      @cmd = MOVE
    when /\A(LEFT)\z/
      @cmd = LEFT
    when /\A(RIGHT)\z/
      @cmd = RIGHT
    when /\A(REPORT)\z/
      @cmd = REPORT
    when EXIT_REGEX
      @cmd = EXIT
    else
      $stdout.puts INVALID_COMMAND_MESSAGE
      @cmd = nil
    end
  end

  def self.read_command
    input = $stdin.gets&.chomp.to_s.upcase
    return nil unless COMMANDS.include?(input) ||
                      input.match(PLACE) ||
                      input.match(EXIT_REGEX)

    input
  end
end
