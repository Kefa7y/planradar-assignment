# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Ticket do
  describe '#user_due_date_reminder_time' do
    let(:result) { ticket.user_due_date_reminder_time }
    # let(:ticket) { instance_spy(Ticket, id: ticket_id, user: user_stub) }

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
  end
end
