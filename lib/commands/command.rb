# frozen_string_literal: true

require_relative '../exceptions'

# This is the base class for issuing commands for robot requests.
#
class Command
  def initialize(map: nil, robot: nil)
    @map = map
    @robot = robot
  end

  def execute
    raise MethodNotImplementedError, "Method #{__method__} not implemented in #{self.class}"
  end
end
