# frozen_string_literal: true

class Ticket < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'assigned_user_id', inverse_of: :tickets

  validates :title, :description, presence: true

  after_create :schedule_user_due_date_reminder
  after_update :schedule_user_due_date_reminder, if: :saved_change_to_due_date?

  def user_due_date_reminder_time
    return nil if due_date.blank?

    notification_date = due_date - user.due_date_reminder_interval
    TimeUtils.set_date_in_time(user.due_date_reminder_time, notification_date)
  end

  def schedule_user_due_date_reminder
    self.jid = if due_date.blank? || !user.send_due_date_reminder?
                 nil
               else
                 Ticket::DueDateReminderNotificationJob.perform_at(user_due_date_reminder_time, id,
                                                                   user.notification_channel)
               end

    if jid_changed?
      SidekiqUtils.delete_scheduled_job_by_jid(jid_was)
      save
    end

    jid
  end
end
