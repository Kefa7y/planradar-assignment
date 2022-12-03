# frozen_string_literal: true

class User < ApplicationRecord
  has_many :tickets, dependent: :destroy

  validates_presence_of :name, :mail
  validates_presence_of :due_date_reminder_time, :time_zone, if: :send_due_date_reminder?
  validates_uniqueness_of :mail

  before_save :parse_due_date_time_with_zone, if: :send_due_date_reminder?

  # This is a stub function for more features to come concerning notification channel
  def notification_channel
    'email'
  end

  private

  def parse_due_date_time_with_zone
    self.due_date_reminder_time = TimeUtils.set_zone_in_time(due_date_reminder_time, time_zone)
  end
end
