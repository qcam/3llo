# frozen_string_literal: true

require 'spec_helper'
require '3llo/card_command_factory'

RSpec.describe Tr3llo::CardCommandFactory do
  describe '#factory' do
    let(:args) { [1] }
    let(:factory) { described_class.new(subcommand, args) }
    subject { factory.factory }

    context 'when subcommand is add' do
      let(:subcommand) { 'add' }
      it { is_expected.to be_a(Tr3llo::Command::Card::AddCommand) }
    end

    context 'when subcommand is show' do
      let(:subcommand) { 'show' }
      it { is_expected.to be_a(Tr3llo::Command::Card::ShowCommand) }
    end

    context 'when subcommand is edit' do
      let(:subcommand) { 'edit' }
      it { is_expected.to be_a(Tr3llo::Command::Card::EditCommand) }
    end

    context 'when subcommand is comments' do
      let(:subcommand) { 'comments' }
      it { is_expected.to be_a(Tr3llo::Command::Card::CommentsCommand) }
    end

    context 'when subcommand is comment' do
      let(:subcommand) { 'comment' }
      it { is_expected.to be_a(Tr3llo::Command::Card::CommentCommand) }
    end

    context 'when subcommand is move' do
      let(:subcommand) { 'move' }
      it { is_expected.to be_a(Tr3llo::Command::Card::MoveCommand) }
    end

    context 'when subcommand is self-assign' do
      let(:subcommand) { 'self-assign' }
      it { is_expected.to be_a(Tr3llo::Command::Card::SelfAssignCommand) }
    end

    context 'when subcommand is assign' do
      let(:subcommand) { 'assign' }
      it { is_expected.to be_a(Tr3llo::Command::Card::AssignCommand) }
    end

    context 'when subcommand is archive' do
      let(:subcommand) { 'archive' }
      it { is_expected.to be_a(Tr3llo::Command::Card::ArchiveCommand) }
    end

    context 'when subcommand is not one of Card, cards or archive cards' do
      let(:subcommand) { 'invalid' }
      it { is_expected.to be_a(Tr3llo::Command::Card::InvalidCommand) }
    end
  end
end