# frozen_string_literal: true

require_relative 'command'

class ExitCommand < Command
  def execute
    $stdout.puts ''
    $stdout.puts '*** Toy Robot out! Bye!'
    $stdout.puts ''

    exit
  end
end
