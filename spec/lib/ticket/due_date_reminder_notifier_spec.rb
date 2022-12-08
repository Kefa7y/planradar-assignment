# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Ticket::DueDateReminderNotifier do
  let(:ticket_id) { 5 }
  let(:channel) { 'email' }
  let(:email) { 'test@planradar.com' }
  let(:notifier) { described_class.new(ticket_id, channel) }
  let(:user_stub) { instance_spy(User, mail: email) }
  let(:ticket_stub) { instance_spy(Ticket, id: ticket_id, user: user_stub) }

  before do
    allow(Ticket).to receive(:find).with(ticket_id).and_return(ticket_stub)
  end

  describe '#initialize' do
    it 'assigns the Ticket class to variable' do
      expect(notifier.ticket).to equal ticket_stub
    end

    it 'assigns the channel to variable' do
      expect(notifier.channel).to equal channel
    end
  end

  describe '#notify' do
    context 'when assigned channel is email' do
      subject! do
        notifier.notify
      end

      it 'delivers the email successfully' do
        stubbed_email = ActionMailer::Base.deliveries.first
        expect(stubbed_email.to.first).to eq email
      end
    end

    context 'when assigned channel is not email' do
      let(:channel) { 'sms' }

      it 'raises a StandardError' do
        expect { notifier.notify }.to raise_error(StandardError, 'Notification channel `sms` is not supported')
      end
    end
  end
end
