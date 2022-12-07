# frozen_string_literal: true

class Ticket
  class DueDateReminderNotifier
    attr_accessor :ticket, :channel

    def initialize(ticket_id, channel)
      @ticket = Ticket.find(ticket_id)
      @channel = channel
    end

    def notify
      case channel
      when 'email'
        ::TicketMailer.with(ticket: @ticket).due_date_reminder_email.deliver_now
      else
        raise StandardError, "Notification channel `#{channel}` is not supported"
      end
    end
  end
end
