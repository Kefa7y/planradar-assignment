# frozen_string_literal: true

require 'spec_helper'

RSpec.describe TimeUtils do
  describe '#set_date_in_time' do
    let(:time_stub) { instance_spy(Time) }
    let(:year) { 2022 }
    let(:month) { 10 }
    let(:day) { 20 }

    before do
      allow(time_stub).to receive(:change).and_return(Time.current)
      described_class.set_date_in_time(time_stub, Date.parse("#{year}-#{month}-#{day}"))
    end

    it 'changes the date components in time' do
      expect(time_stub).to have_received(:change).once.with({ year: year, month: month, day: day })
    end
  end

  describe '#parse_time_of_day' do
    context 'when passing time = nil' do
      it 'returns nil' do
        expect(described_class.parse_time_of_day(nil)).to eq nil
      end
    end

    context 'when passing valid time' do
      let(:expected) { '08:00AM EET' }

      it 'returns a string containing time of day and time zone' do
        time = Time.zone.parse(expected)
        expect(described_class.parse_time_of_day(time)).to eq expected
      end
    end
  end

  describe '#set_zone_in_time' do
    let(:time) { Time.parse('8:00AM').utc }
    let(:time_zone) { 'EET' }
    let(:result) { described_class.set_zone_in_time(time, time_zone) }

    it 'changes the time zone' do
      expect(result.zone).to eq time_zone
    end

    it 'does not change the hours marker along with the zone change' do
      expect(result.hour).to equal time.hour
    end
  end
end
