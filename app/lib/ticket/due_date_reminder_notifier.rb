# frozen_string_literal: true

class Ticket
  class DueDateReminderNotifier
    attr_accessor :ticket, :channel, :user

    def initialize(ticket_id, channel)
      @ticket = Ticket.find(ticket_id)
      @channel = channel
      @user = @ticket.user
    end

    def notify
      Sidekiq.logger.debug("DueDateReminderNotifier ticket_id: #{ticket.id}, user_id:#{user.id}, channel: #{channel}")

      case channel
      when 'email'
        TicketMailer.with(ticket: Ticket.first).due_date_reminder_email.deliver_now
      else
        raise StandardError, "Notification channel `#{channel}` is not supported"
      end
    end
  end
end
