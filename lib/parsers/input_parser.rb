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
end
