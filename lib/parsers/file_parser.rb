# frozen_string_literal: true

require_relative 'parser'

# This class parses the test data file.
#
class FileParser < Parser
  attr_accessor :file

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
end
