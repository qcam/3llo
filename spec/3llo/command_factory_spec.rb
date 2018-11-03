require '3llo/command_factory'
require 'spec_helper'

RSpec.describe Tr3llo::CommandFactory do
  describe '#factory' do
    let(:factory) { described_class.new(command_buffer) }
    subject { factory.factory }

    context 'when command is board' do
      let(:command_buffer) { 'board something arg1 arg2' }
      let(:command_object) { double('Command') }

      before do
        sub_factory = instance_double('Tr3llo::BoardCommandFactory', factory: command_object)
        expect(Tr3llo::BoardCommandFactory).to receive(:new)
          .with('something', ['arg1', 'arg2']).and_return(sub_factory)
      end

      it { is_expected.to eq command_object }
    end

    context 'when command is card' do
      let(:command_buffer) { 'card something arg1 arg2' }
      let(:command_object) { double('Command') }

      before do
        sub_factory = instance_double('Tr3llo::CardCommandFactory', factory: command_object)
        expect(Tr3llo::CardCommandFactory).to receive(:new)
          .with('something', ['arg1', 'arg2']).and_return(sub_factory)
      end

      it { is_expected.to eq command_object }
    end

    context 'when command is list' do
      let(:command_buffer) { 'list something arg1 arg2' }
      let(:command_object) { double('Command') }

      before do
        sub_factory = instance_double('Tr3llo::ListCommandFactory', factory: command_object)
        expect(Tr3llo::ListCommandFactory).to receive(:new)
          .with('something', ['arg1', 'arg2']).and_return(sub_factory)
      end

      it { is_expected.to eq command_object }
    end

    context 'when command is help' do
      let(:command_buffer) { 'help card' }
      it { is_expected.to be_a(Tr3llo::Command::HelpCommand) }
    end

    context 'when command is exit' do
      let(:command_buffer) { 'exit' }
      it { is_expected.to be_a(Tr3llo::Command::ExitCommand) }
    end

    context 'when command is empty' do
      let(:command_buffer) { '' }
      it { is_expected.to be_a(Tr3llo::Command::InvalidCommand) }
    end

    context 'when command is invalid' do
      let(:command_buffer) { 'invalid' }
      it { is_expected.to be_a(Tr3llo::Command::InvalidCommand) }
    end

    context 'when there is error when parsing command' do
      let(:command_buffer) { 'board something arg1 arg2' }

      before do
        sub_factory = instance_double('Tr3llo::BoardCommandFactory')
        expect(Tr3llo::BoardCommandFactory).to receive(:new)
          .with('something', ['arg1', 'arg2']).and_return(sub_factory)
        expect(sub_factory).to receive(:factory)
          .and_raise(Container::KeyNotFoundError.new(:key))
      end

      it { is_expected.to be_a(Tr3llo::Command::ErrorCommand) }
    end
  end
end
