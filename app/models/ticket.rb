# frozen_string_literal: true

class Ticket < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'assigned_user_id'

  def user_due_date_reminder_time
    return nil if user.nil?

    notification_date = due_date - user.due_date_reminder_interval
    TimeUtils.set_date_in_time(user.due_date_reminder_time, notification_date).in_time_zone(user.time_zone)
  end
end
