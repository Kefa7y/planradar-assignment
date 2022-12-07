# frozen_string_literal: true

module SidekiqUtils
  class << self
    def delete_scheduled_job_by_jid(jid)
      return false if jid.blank?

      scheduled_set = Sidekiq::ScheduledSet.new
      job = scheduled_set.find_job(jid)

      job.present? ? job.delete : false
    end
  end
end
