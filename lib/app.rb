# frozen_string_literal: true

require_relative 'parser'
require_relative 'map'
require_relative 'errors'

# This class is responsible to run the game by:
#  * parsing the user commands
#  * changing the internal state
#  * printing the current state of the robot
#
class App
  def initialize(map_max_x, map_max_y)
    @map = Map.new(max_x: map_max_x, max_y: map_max_y)
  end

  def run
    welcome

    loop do
      command = Parser.command
      if Parser.exit?
        $stdout.puts ''
        $stdout.puts '*** Toy Robot out! Bye!'
        $stdout.puts ''
        break
      end

      execute_command(command)
    rescue MapSetupError, InvalidMoveError => e
      $stdout.puts e.message
    end
  end

  def welcome
    $stdout.puts ''
    $stdout.puts '*** Welcome to Toy Robot! Take control of the robot! ***'
    $stdout.puts '>>> Please issue your commands:'
  end

  private

  def execute_command(command) # rubocop:disable Metrics/AbcSize
    if Parser.place?
      args = command.split(/PLACE\s*/)[1].split(/,\s*/)
      @map.place(x: args[0].to_i, y: args[1].to_i, direction: args[2])
    elsif Parser.move?
      @map.move
    elsif Parser.right?
      @map.turn_right
    elsif Parser.left?
      @map.turn_left
    elsif Parser.report?
      $stdout.puts @map.report
    end
  end
end
