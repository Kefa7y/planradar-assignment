# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Ticket::DueDateReminderNotificationJob do
  let(:job) { described_class.new }

  describe '#perform' do
    let(:ticket_id) { 1 }
    let(:notification_channel) { 'email' }
    let(:notify_return) { 'Notified' }
    let(:notifier_stub) { instance_spy(Ticket::DueDateReminderNotifier) }

    before do
      allow(Ticket::DueDateReminderNotifier).to receive(:new).and_return(notifier_stub)
      allow(notifier_stub).to receive(:notify).and_return(notify_return)
      job.perform(ticket_id, notification_channel)
    end

    it 'calls new on Ticket::DueDateReminderNotifier' do
      expect(Ticket::DueDateReminderNotifier).to have_received(:new).once.with(ticket_id, notification_channel)
    end

    it 'calls notify on Ticket::DueDateReminderNotifier instance' do
      expect(notifier_stub).to have_received(:notify).once.with(no_args)
    end
  end
end
