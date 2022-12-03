# frozen_string_literal: true

class Ticket < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'assigned_user_id'

  after_create :schedule_user_due_date_reminder

  def user_due_date_reminder_time
    return nil if user.nil?

    notification_date = due_date - user.due_date_reminder_interval
    TimeUtils.set_date_in_time(user.due_date_reminder_time, notification_date).in_time_zone(user.time_zone)
  end

  def schedule_user_due_date_reminder
    return unless user.send_due_date_reminder?

    Ticket::DueDateReminderNotificationJob.perform_at(user_due_date_reminder_time, id, user.notification_channel)
    # TODO: Add logic for job id persistence in case of user notification preference change OR due_date change
  end
end
