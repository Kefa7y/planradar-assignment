# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SidekiqUtils do
  describe '#delete_scheduled_job_by_jid' do
    context 'when passing jid = nil' do
      it 'returns false' do
        expect(described_class.delete_scheduled_job_by_jid(nil)).to eq false
      end
    end

    context 'when passing an actual jid' do
      let(:jid) { 'dummy_jid' }
      let(:sidekiq_scheduled_set_stub) { instance_spy(Sidekiq::ScheduledSet) }

      context 'when jid exists' do
        let(:sidekiq_job_stub) { instance_spy(Sidekiq::SortedEntry) }

        before do
          allow(Sidekiq::ScheduledSet).to receive(:new).and_return(sidekiq_scheduled_set_stub)
          allow(sidekiq_scheduled_set_stub).to receive(:find_job).with(jid).and_return(sidekiq_job_stub)
          allow(sidekiq_job_stub).to receive(:delete).and_return(true)
          @result = described_class.delete_scheduled_job_by_jid(jid)
        end

        it('calls Sidekiq::ScheduledSet.new') do
          expect(Sidekiq::ScheduledSet).to have_received(:new).once.with(no_args)
        end

        it('calls find_job on the newly created Sidekiq::ScheduledSet') do
          expect(sidekiq_scheduled_set_stub).to have_received(:find_job).once.with(jid)
        end

        it('calls delete on the newly fetched Sidekiq::SortedEntry instance') do
          expect(sidekiq_job_stub).to have_received(:delete).once.with(no_args)
        end

        it('returns true') do
          expect(@result).to eq true # rubocop:disable Rails/InstanceVariable
        end
      end

      context 'when jid does not exist' do
        before do
          allow(Sidekiq::ScheduledSet).to receive(:new).and_return(sidekiq_scheduled_set_stub)
          allow(sidekiq_scheduled_set_stub).to receive(:find_job).with(jid).and_return(nil)
          @result = described_class.delete_scheduled_job_by_jid(jid)
        end

        it('calls Sidekiq::ScheduledSet.new') do
          expect(Sidekiq::ScheduledSet).to have_received(:new).once.with(no_args)
        end

        it('calls find_job on the newly created Sidekiq::ScheduledSet') do
          expect(sidekiq_scheduled_set_stub).to have_received(:find_job).once.with(jid)
        end

        it('returns false') do
          expect(@result).to eq false # rubocop:disable Rails/InstanceVariable
        end
      end
    end
  end
end
