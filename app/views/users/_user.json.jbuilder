# frozen_string_literal: true

json.extract! user, :id, :name, :mail, :send_due_date_reminder, :due_date_reminder_interval, :time_zone
json.due_date_reminder_time user.due_date_reminder_time.in_time_zone(user.time_zone).strftime('%I:%M%p %Z')
json.url user_url(user)
