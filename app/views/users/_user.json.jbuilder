# frozen_string_literal: true

json.extract! user, :id, :name, :mail, :send_due_date_reminder, :due_date_reminder_interval, :due_date_reminder_time,
              :time_zone
json.url user_url(user)
