# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/app'

RSpec.describe App do
  let(:instance) { described_class.new }

  describe '#run' do
    context 'welcome message' do
      before do
        $stdin = StringIO.new("PLACE 0,0,NORTH\nREPORT\nquit\n")
      end

      it 'puts a welcome message to stdout' do
        expect { instance.run }.to output(/Welcome to Toy Robot!/).to_stdout
      end
    end

    context 'with invalid commands' do
      before do
        $stdin = StringIO.new("PLACE 0,0,NORTH\nINVALID\nREPORT\nquit\n")
      end

      it 'should print a message' do
        expect { instance.run }.to output(/Command: invalid!/).to_stdout
      end
    end

    context 'with valid commands' do
      context 'with REPORT' do
        before do
          $stdin = StringIO.new("PLACE 0,0,NORTH\nREPORT\nquit\n")
        end

        it 'should quit execution' do
          expect(instance.run).to eq(nil)
        end
      end

      context 'case 1: with a sequence of commands' do
        before do
          $stdin = StringIO.new("PLACE 0,0,NORTH\nMOVE\nLEFT\nRIGHT\nREPORT\nquit\n")
        end

        it 'should quit execution' do
          expect { instance.run }.to output(/0,1,NORTH/).to_stdout
        end
      end

      context 'case 2: with a sequence of commands' do
        before do
          $stdin = StringIO.new("PLACE 2,1,EAST\nMOVE\nLEFT\nMOVE\nMOVE\nREPORT\nquit\n")
        end

        it 'should quit execution' do
          expect { instance.run }.to output(/3,3,NORTH/).to_stdout
        end
      end

      context 'case 3: with a sequence of commands' do
        before do
          $stdin = StringIO.new("PLACE 1,2,EAST\nMOVE\nMOVE\nLEFT\nMOVE\nREPORT\nquit\n")
        end

        it 'should quit execution' do
          expect { instance.run }.to output(/3,3,NORTH/).to_stdout
        end
      end
    end

    context 'when robot is not placed' do
      before do
        $stdin = StringIO.new("REPORT\nPLACE 0,0,NORTH\nREPORT\nquit\n")
      end

      it 'puts a message to stdout' do
        expect { instance.run }.to output(/Robot is not placed yet!/).to_stdout
      end
    end

    context 'when robot may fall' do
      before do
        $stdin = StringIO.new("PLACE 0,0,SOUTH\nMOVE\nREPORT\nquit\n")
      end

      it 'puts a message to stdout' do
        expect { instance.run }.to output(/Robot may fall!/).to_stdout
      end
    end

    context 'with wrong coordination' do
      before do
        $stdin = StringIO.new("PLACE -1,7,SOUTH\nPLACE 0,0,SOUTH\nREPORT\nquit\n")
      end

      it 'puts a message to stdout' do
        expect { instance.run }.to output(/Wrong coordination\(s\)/).to_stdout
      end
    end
  end
end
