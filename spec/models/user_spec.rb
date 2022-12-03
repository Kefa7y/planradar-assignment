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
    let(:expected_time) { due_date_reminder_time + 1.day }
    let(:result) { user.send(:parse_due_date_time_with_zone) }

    before do
      allow(TimeUtils).to receive(:set_zone_in_time).and_return(expected_time)
    end

    it 'invokes TimeUtils.set_zone_in_time with the correct parameters' do
      result
      expect(TimeUtils).to have_received(:set_zone_in_time)
        .once.with(due_date_reminder_time, time_zone)
    end

    it 'returns the return value from TimeUtils.set_zone_in_time' do
      expect(result).to equal expected_time
    end
  end
end
