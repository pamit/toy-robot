# frozen_string_literal: true

require_relative 'lib/app'

namespace :robot do
  desc 'Start the game'
  task :run, [:max_x, :max_y] do |_, args|
    args.with_defaults(max_x: 5, max_y: 5)
    puts "[::] Calling Rake task with: #{args}"

    App.new(args[:max_x], args[:max_y]).run
  end
end
