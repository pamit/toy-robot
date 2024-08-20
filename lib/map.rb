# frozen_string_literal: true

require_relative 'exceptions'

# This class represents the map/table.
#
class Map
  MAP_DEFAULT_WIDTH  = 5
  MAP_DEFAULT_HEIGHT = 5
  MAP_MAX_WIDTH      = 10_000
  MAP_MAX_HEIGHT     = 10_000

  attr_reader :max_x, :max_y, :obstacles

  def initialize(max_x = MAP_DEFAULT_WIDTH, max_y = MAP_DEFAULT_HEIGHT, obstacles = [])
    raise MapSetupError, 'Map size exceeds max (10_000)' if max_x.to_i > MAP_MAX_WIDTH || max_y.to_i > MAP_MAX_HEIGHT
    raise MapSetupError, 'Map size must be greater than 0' if max_x.to_i <= 0 || max_y.to_i <= 0

    @max_x = max_x.to_i
    @max_y = max_y.to_i
    @obstacles = obstacles
  end

  def valid_move?(position)
    (0..@max_x - 1).include?(position.x) && (0..@max_y - 1).include?(position.y)
  end

  def hit_obstacle?(position)
    return true if @obstacles.nil?

    @obstacles.include?(position.to_point)
  end

  def neighbors(position)
    result = []

    [[1, 0], [0, 1], [-1, 0], [0, -1]].each do |x, y|
      neighbor = Position.new(position.x + x, position.y + y)
      result << neighbor if valid_move?(neighbor) && !hit_obstacle?(neighbor)
    end

    result
  end
end
