# frozen_string_literal: true

require_relative 'command'

class ReportCommand < Command
  def execute
    $stdout.puts ">>> Current position: #{@robot.report}"
  end
end
