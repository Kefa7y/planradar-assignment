# frozen_string_literal: true

class User < ApplicationRecord
  has_many :tickets, dependent: :destroy, foreign_key: 'assigned_user_id', inverse_of: :user

  validates :name, :mail, presence: true
  validates :due_date_reminder_time, :time_zone, presence: { if: :send_due_date_reminder? }
  validates :mail, uniqueness: true

  before_save :parse_due_date_time_with_zone, if: :send_due_date_reminder?
  after_update :reschedule_tickets_due_date_reminder, if: :reschedule_tickets_due_date_reminder?

  # This is a stub function for more features to come concerning notification channel
  def notification_channel
    'email'
  end

  def reschedule_tickets_due_date_reminder
    tickets.each(&:schedule_user_due_date_reminder)
  end

  private

  def parse_due_date_time_with_zone
    self.due_date_reminder_time = TimeUtils.set_zone_in_time(due_date_reminder_time, time_zone)
  end

  def reschedule_tickets_due_date_reminder?
    saved_change_to_send_due_date_reminder? ||
      saved_change_to_due_date_reminder_interval? ||
      saved_change_to_due_date_reminder_time?
  end
end
