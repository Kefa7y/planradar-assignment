# frozen_string_literal: true

require 'spec_helper'

RSpec.describe User do
  let(:user) do
    described_class.new(name: 'Mohamed', mail: 'mohamed.ash.roshdy@outlook.com', send_due_date_reminder: true,
                        due_date_reminder_time: '8:00', time_zone: 'Cairo')
  end
  let(:time_zone) { user.time_zone }
  let(:due_date_reminder_time) { user.due_date_reminder_time }

  describe '#notification_channel' do
    it 'returns `email`' do
      expect(user.notification_channel).to eq 'email'
    end
  end

  describe '#parse_due_date_time_with_zone' do
    subject!(:result) do
      allow(TimeUtils).to receive(:set_zone_in_time).and_return(expected_time)
      user.send(:parse_due_date_time_with_zone)
    end

    let(:expected_time) { due_date_reminder_time + 1.day }

    it 'invokes TimeUtils.set_zone_in_time with the correct parameters' do
      expect(TimeUtils).to have_received(:set_zone_in_time)
        .once.with(due_date_reminder_time, time_zone)
    end

    it 'returns the return value from TimeUtils.set_zone_in_time' do
      expect(result).to equal expected_time
    end
  end

  describe '#reschedule_tickets_due_date_reminder' do
    subject! do
      allow(user).to receive(:tickets).and_return(tickets_array)
      user.reschedule_tickets_due_date_reminder
    end

    let(:ticket_stub_one) { instance_spy(Ticket) }
    let(:ticket_stub_two) { instance_spy(Ticket) }
    let(:tickets_array) { [ticket_stub_one, ticket_stub_two] }

    it 'invokes tickets on User instance' do
      expect(user).to have_received(:tickets).once.with(no_args)
    end

    it 'invokes schedule_user_due_date_reminder on each member of tickets array' do
      expect(tickets_array).to all(have_received(:schedule_user_due_date_reminder).once.with(no_args))
    end
  end

  describe '#reschedule_tickets_due_date_reminder?' do
    subject!(:result) do
      change_variables.each do |change_variable|
        function_name = "saved_change_to_#{change_variable}?"
        allow(user).to receive(function_name.to_sym).and_call_original
      end

      user.send(:reschedule_tickets_due_date_reminder?)
    end

    let(:change_variables) { %w[send_due_date_reminder due_date_reminder_interval due_date_reminder_time] }

    it 'invokes all change variables ActiveModel saved_change functions' do
      change_variables.each do |change_variable|
        function_name = "saved_change_to_#{change_variable}?"
        expect(user).to have_received(function_name.to_sym).once.with(no_args)
      end
    end

    it 'returns false if change_variables did not change' do
      expect(result).to equal(false)
    end
  end
end
