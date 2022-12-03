# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Ticket do
  describe '#user_due_date_reminder_time' do
    let(:result) { ticket.user_due_date_reminder_time }

    context 'when due_date is blank' do
      let(:ticket) { described_class.new(title: 'title', description: 'description', due_date: nil) }

      it 'returns nil' do
        expect(result).to equal nil
      end
    end

    context 'when due_date is present' do
      let(:delay_in_days) { 5 }
      let(:user_stub) do
        instance_spy(User, due_date_reminder_interval: delay_in_days, due_date_reminder_time: Time.parse('08:00AM'))
      end
      let(:ticket) do
        described_class.new(title: 'title', description: 'description', due_date: Date.parse('2022-10-20'))
      end
      let(:test_time) { Time.current }

      before do
        allow(TimeUtils).to receive(:set_date_in_time).and_return(test_time)
        allow(ticket).to receive(:user).and_return(user_stub)
      end

      it 'returns nil' do
        expect(result).to equal test_time
      end

      it 'calls show_cheapest with direct=true' do
        result
        expect(TimeUtils).to have_received(:set_date_in_time).once.with(user_stub.due_date_reminder_time,
                                                                        ticket.due_date - delay_in_days.days)
      end
    end
  end

  describe '#schedule_user_due_date_reminder' do
    let(:result) { ticket.schedule_user_due_date_reminder }

    context 'when due_date is blank' do
      let(:ticket) { described_class.new(title: 'title', description: 'description', due_date: nil) }

      it 'returns nil' do
        expect(result).to equal nil
      end
    end

    context 'when due_date is present' do
      let(:ticket) do
        described_class.new(title: 'title', description: 'description', due_date: Date.parse('2022-10-20'))
      end
      let(:execution_time) { Time.current }
      let(:jid) { 'dummy_jid' }

      before do
        allow(ticket).to receive(:user).and_return(user_stub)
        allow(ticket).to receive(:user_due_date_reminder_time).and_return(execution_time)
        allow(Ticket::DueDateReminderNotificationJob).to receive(:perform_at).and_return(jid)
      end

      context 'when user send_due_date_reminder is false' do
        let(:user_stub) do
          instance_spy(User, send_due_date_reminder?: false)
        end

        it 'returns nil' do
          expect(result).to equal nil
        end
      end

      context 'when user send_due_date_reminder is true' do
        let(:user_stub) do
          instance_spy(User, send_due_date_reminder?: true, notification_channel: 'email')
        end

        it 'returns scheduled job id' do
          expect(result).to equal jid
        end

        it 'schedules Ticket::DueDateReminderNotificationJob' do
          result
          expect(Ticket::DueDateReminderNotificationJob).to have_received(:perform_at)
            .once.with(execution_time, ticket.id, user_stub.notification_channel)
        end
      end
    end
  end
end
