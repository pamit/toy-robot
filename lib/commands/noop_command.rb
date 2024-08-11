# frozen_string_literal: true

require_relative 'command'

class NoopCommand < Command
  def execute
    $stdout.puts 'Invalid command!'
  end
end
