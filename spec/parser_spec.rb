# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/parser'

RSpec.describe Parser do
  let(:instance) { described_class }

  describe '.command' do
    context 'with invalid command' do
      let(:input) { 'INVALID\n' }

      before do
        $stdin = StringIO.new(input)
      end

      it 'should return nil' do
        expect(instance.command).to eq(nil)
      end

      it 'puts a message to stdout' do
        expect { instance.command }.to output(/Command: invalid!/).to_stdout
      end
    end

    context 'with valid command' do
      (Parser::COMMANDS - [Parser::PLACE]).each do |cmd|
        it 'should return the command' do
          $stdin = StringIO.new(cmd)
          expect(instance.command).to eq(cmd)
        end
      end
    end

    context 'with valid PLACE' do
      it 'should return command with args' do
        $stdin = StringIO.new("PLACE 0,0,NORTH\n")
        expect(instance.command).to eq("PLACE 0,0,NORTH")
      end
    end
  end
end
