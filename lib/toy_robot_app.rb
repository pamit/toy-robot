# frozen_string_literal: true

require_relative 'parsers/input_parser'
require_relative 'parsers/file_parser'
require_relative 'map'
require_relative 'robot'
require_relative 'exceptions'
require 'byebug'

# This class is responsible to run the game by:
#  * parsing and executing user's commands
#  * updating the internal state
#  * printing the current state of the robot
#
class ToyRobotApp
  attr_reader :map, :parser

  def initialize(map, parser)
    @map = map
    @parser = parser
  end

  # Sample Builder class to demonstrate the Builder pattern usage
  # for constructing complex objects
  class Builder
    attr_reader :map_max_x, :map_max_y, :obstacles, :file

    def self.max_x(value)
      @map_max_x = value
      self
    end

    def self.max_y(value)
      @map_max_y = value
      self
    end

    def self.input_file(value)
      @file = value
      self
    end

    def self.obstacles(value)
      @obstacles = value
      self
    end

    def self.build
      @map = Map.new(@map_max_x, @map_max_y, @obstacles)
      @robot = Robot.new

      # Injecting Parser to ToyRobotApp
      ToyRobotApp.new(@map, parser)
    end

    def self.parser
      if @file.nil?
        InputParser.new(@map, @robot)
      else
        FileParser.new(@map, @robot, @file)
      end
    end
  end

  def run
    welcome
    @parser.command
  rescue MapSetupError, InvalidMoveError, NotImplementedError => e
    # Log exceptions for monitoring
    $stdout.puts e.message
  end

  def welcome
    $stdout.puts ''
    $stdout.puts '*** Welcome to Toy Robot! ***'
    $stdout.puts "[map: #{@map.max_x}x#{@map.max_y} - #{@parser.instance_of?(InputParser) ? 'terminal' : 'file'}]"
    $stdout.puts '>>> Please issue your commands:'
  end
end
