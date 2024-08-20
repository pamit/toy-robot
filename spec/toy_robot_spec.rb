# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/toy_robot_app'

RSpec.describe ToyRobotApp do
  let(:instance) do
    described_class::Builder
      .max_x(5)
      .max_y(5)
      .build
  end

  describe '#run' do
    context 'with file parser' do
      let(:instance) do
        described_class::Builder
          .max_x(5)
          .max_y(5)
          .input_file('test.txt')
          .build
      end

      it 'sets parser to FileParser' do
        expect(instance.parser.class).to eq(FileParser)
      end
    end

    context 'with obstacles' do
      let(:obstacles) { [[0, 0], [4, 4]] }
      let(:instance) do
        described_class::Builder
          .max_x(5)
          .max_y(5)
          .obstacles(obstacles)
          .build
      end

      before do
        @prev_stdin = $stdin
      end

      after do
        $stdin = @prev_stdin
      end

      it 'returns error if hit an obstacle' do
        $stdin = StringIO.new("PLACE 0,0,NORTH\nREPORT\nquit\n")
        expect { instance.run }.to output(/Wrong coordination/).to_stdout
      end
    end

    # context 'with invalid commands' do
    #   it 'should print a message' do
    #     $stdin = StringIO.new("PLACE 0,0,NORTH\nINVALID\nREPORT\nquit\n")
    #     expect { instance.run }.to output(/Invalid command!/).to_stdout
    #   end
    # end

    # context 'with valid commands' do
    #   context 'with REPORT' do
    #     it 'should quit execution' do
    #       $stdin = StringIO.new("PLACE 0,0,NORTH\nREPORT\nquit\n")
    #       expect(instance.run).to eq(nil)
    #     end
    #   end

    #   context 'case 1: with a sequence of commands' do
    #     it 'should quit execution' do
    #       $stdin = StringIO.new("PLACE 0,0,NORTH\nMOVE\nLEFT\nRIGHT\nREPORT\nquit\n")
    #       expect { instance.run }.to output(/0,1,NORTH/).to_stdout
    #     end
    #   end

    #   context 'case 2: with a sequence of commands' do
    #     it 'should quit execution' do
    #       $stdin = StringIO.new("PLACE 2,1,EAST\nMOVE\nLEFT\nMOVE\nMOVE\nREPORT\nquit\n")
    #       expect { instance.run }.to output(/3,3,NORTH/).to_stdout
    #     end
    #   end

    #   context 'case 3: with a sequence of commands' do
    #     it 'should quit execution' do
    #       $stdin = StringIO.new("PLACE 1,2,EAST\nMOVE\nMOVE\nLEFT\nMOVE\nREPORT\nquit\n")
    #       expect { instance.run }.to output(/3,3,NORTH/).to_stdout
    #     end
    #   end
    # end

    # context 'when robot is not placed' do
    #   it 'puts a message to stdout' do
    #     $stdin = StringIO.new("REPORT\nPLACE 0,0,NORTH\nREPORT\nquit\n")
    #     expect { instance.run }.to output(/Robot is not placed yet!/).to_stdout
    #   end
    # end

    # context 'when robot may fall' do
    #   it 'puts a message to stdout' do
    #     $stdin = StringIO.new("PLACE 0,0,SOUTH\nMOVE\nREPORT\nquit\n")
    #     expect { instance.run }.to output(/Robot may fall!/).to_stdout
    #   end
    # end

    # context 'with wrong coordination' do
    #   it 'puts a message to stdout' do
    #     $stdin = StringIO.new("PLACE -1,7,SOUTH\nPLACE 0,0,SOUTH\nREPORT\nquit\n")
    #     expect { instance.run }.to output(/Wrong coordination\(s\)/).to_stdout
    #   end
    # end
  end
end
