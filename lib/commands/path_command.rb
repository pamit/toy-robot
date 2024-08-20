# frozen_string_literal: true

require 'set'
require_relative 'command'

class PathCommand < Command
  def initialize(map: nil, robot: nil, destination: nil)
    super(map:, robot:)
    @destination = destination
  end

  def execute
    raise MapSetupError, 'Robot is not placed yet!' unless @robot.placed?

    path = find_bfs_path
    if path.empty?
      $stdout.puts ">>> No path to (#{@destination.to_point}) found!"
    else
      $stdout.puts ">>> Path to (#{@destination.to_point}) is: #{path}"
    end
  end

  private

  def find_bfs_path
    queue = [[@robot.position]]
    visited = Set.new

    while !queue.empty? # rubocop:disable Style/NegatedWhile
      path = queue.shift
      node = path[-1]
      visited << node.to_point

      return path.map(&:to_point) if node == @destination

      @map.neighbors(node).each do |neighbor|
        next if visited.include?(neighbor.to_point)

        new_path = path.dup
        new_path << neighbor
        queue << new_path
      end
    end

    []
  end
end
