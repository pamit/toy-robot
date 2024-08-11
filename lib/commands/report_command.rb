# frozen_string_literal: true

require_relative 'command'

class ReportCommand < Command
  def execute
    $stdout.puts @robot.report
  end
end
