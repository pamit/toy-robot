# frozen_string_literal: true

require_relative 'toy_robot_app'
require 'optparse'

begin
  # CLI options
  # ex: ruby lib/main.rb --max-x=4 --max-y=3 --file=text.txt
  options = {}
  OptionParser.new do |parser|
    parser.on('-x', '--max-x[MAX-X]') do |x|
      options[:max_x] = x.to_i || 5
    end

    parser.on('-y', '--max-y[MAX-Y]') do |y|
      options[:max_y] = y.to_i || 5
    end

    parser.on('-f', '--file[FILE]') do |f|
      options[:file] = f
    end
  end.parse!
  # p options

  # Initialize the app
  ToyRobotApp::Builder
    .max_x(options[:max_x])
    .max_y(options[:max_y])
    .input_file(options[:file])
    .build
    .run
rescue StandardError => e
  puts "App failed: #{e.message}"
end
