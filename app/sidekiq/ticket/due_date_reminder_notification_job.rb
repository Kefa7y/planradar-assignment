# frozen_string_literal: true

class Ticket
  class DueDateReminderNotificationJob
    include Sidekiq::Job

    def perform(ticket_id, notification_channel)
      notifier = Ticket::DueDateReminderNotifier.new(ticket_id, notification_channel)
      notifier.notify
    end
  end
end
