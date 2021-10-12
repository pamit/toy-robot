# frozen_string_literal: true

require_relative 'parser'
require_relative 'map'
require_relative 'errors'
require 'byebug'

# This class is responsible to run the game by:
#  * parsing the user commands
#  * changing the internal state
#  * printing the current state of the robot
#
class App
  def initialize
    @map = Map.new
  end

  def run
    welcome

    loop do
      command = Parser.command
      break if Parser.exit?

      execute_command(command)
    rescue MapSetupError => e
      $stdout.puts e.message
    rescue InvalidMoveError => e
      $stdout.puts e.message
    end
  end

  def welcome
    $stdout.puts '*** Welcome to Toy Robot! Take control of the robot! ***'
    $stdout.puts '>>> Please issue your commands:'
  end

  private

  def execute_command(command) # rubocop:disable Metrics/AbcSize
    if Parser.place?
      args = command.split(/ /)[1].split(/,/)
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
