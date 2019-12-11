# frozen_string_literal: true

require '3llo/presenter/confirmation'

RSpec.describe Tr3llo::Presenter::ConfirmationPresenter do
  describe '#promt_for_confirmation' do
    let(:message) { 'message' }
    let(:input) { double('Input') }
    let(:interface) { double('Interface', input: input) }
    let(:presenter) { described_class.new(interface) }
    subject { presenter.prompt_for_confirmation(message) }

    before do
      expect(input).to receive(:select)
        .with(message, %w[No Yes]).and_return(answer)
    end

    context 'when answer is yes' do
      let(:answer) { 'Yes' }
      it { is_expected.to eq true }
    end

    context 'when answer is not yes' do
      let(:answer) { 'No' }
      it { is_expected.to eq false }
    end
  end
end
