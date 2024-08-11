# frozen_string_literal: true

require 'byebug'
require_relative 'parser'
require_relative 'map'
require_relative 'robot'
require_relative 'exceptions'

# This class is responsible to run the game by:
#  * parsing and executing user's commands
#  * updating the internal state
#  * printing the current state of the robot
#
class ToyRobotApp
  attr_reader :robot

  def initialize(map_max_x, map_max_y)
    @map = Map.new(map_max_x, map_max_y)
    @robot = Robot.new
  end

  # Sample Builder class to demonstrate the Builder pattern usage
  # for constructing complex objects
  class Builder
    attr_reader :map_max_x, :map_max_y

    def self.max_x(value)
      @map_max_x = value
      self
    end

    def self.max_y(value)
      @map_max_y = value
      self
    end

    def self.build
      ToyRobotApp.new(@map_max_x, @map_max_y)
    end
  end

  def run
    welcome

    loop do
      command = Parser.command(@map, @robot)
      command.execute
    rescue MapSetupError, InvalidMoveError, NotImplementedError => e
      # Log exceptions for monitoring
      $stdout.puts e.message
    end
  end

  def welcome
    $stdout.puts ''
    $stdout.puts '*** Welcome to Toy Robot! Take control of the robot! ***'
    $stdout.puts '>>> Please issue your commands:'
  end
end
