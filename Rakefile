# frozen_string_literal: true

require_relative 'lib/toy_robot_app'

namespace :robot do
  desc 'Start the game'
  task :run, [:max_x, :max_y] do |_, args|
    args.with_defaults(max_x: 5, max_y: 5)
    puts "[::] Calling Rake task with: #{args}"

    ToyRobotApp::Builder
      .max_x(args[:max_x])
      .max_y(args[:max_y])
      .build
      .run
  end
end
