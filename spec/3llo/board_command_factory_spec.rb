# frozen_string_literal: true

require 'spec_helper'
require '3llo/board_command_factory'

RSpec.describe Tr3llo::BoardCommandFactory do
  describe '#factory' do
    let(:args) { {} }
    let(:factory) { described_class.new(subcommand, args) }
    subject { factory.factory }

    context 'when subcommand is list' do
      let(:subcommand) { 'list' }
      it { is_expected.to be_a(Tr3llo::Command::Board::ListCommand) }
    end

    context 'when subcommand is l' do
      let(:subcommand) { 'l' }
      it { is_expected.to be_a(Tr3llo::Command::Board::ListCommand) }
    end

    context 'when subcommand is select' do
      let(:subcommand) { 'select' }
      it { is_expected.to be_a(Tr3llo::Command::Board::SelectCommand) }
    end

    context 'when subcommand is s' do
      let(:subcommand) { 's' }
      it { is_expected.to be_a(Tr3llo::Command::Board::SelectCommand) }
    end

    context 'when subcommand is neither list nor select' do
      let(:subcommand) { 'invalid' }
      it { is_expected.to be_a(Tr3llo::Command::Board::InvalidCommand) }
    end
  end
end
