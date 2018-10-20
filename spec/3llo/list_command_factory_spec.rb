require 'spec_helper'
require_relative '../../lib/3llo/list_command_factory'

RSpec.describe Tr3llo::ListCommandFactory do
  describe '#factory' do
    let(:args) { [1] }
    let(:factory) { described_class.new(subcommand, args) }
    subject { factory.factory }

    context 'when subcommand is list' do
      let(:subcommand) { 'list' }
      it { is_expected.to be_a(Tr3llo::Command::List::ListCommand) }
    end

    context 'when subcommand is cards' do
      let(:subcommand) { 'cards' }
      it { is_expected.to be_a(Tr3llo::Command::List::CardsCommand) }
    end

    context 'when subcommand is archive cards' do
      let(:subcommand) { 'archive-cards' }
      it { is_expected.to be_a(Tr3llo::Command::List::ArchiveCardsCommand) }
    end

    context 'when subcommand is not one of list, cards or archive cards' do
      let(:subcommand) { 'invalid' }
      it { is_expected.to be_a(Tr3llo::Command::List::InvalidCommand) }
    end
  end
end
