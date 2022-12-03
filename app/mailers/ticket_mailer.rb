# frozen_string_literal: true

class TicketMailer < ApplicationMailer
  def due_date_reminder_email
    @ticket = params[:ticket]
    @user = @ticket.user

    mail(to: @user.mail, subject: 'Ticket Due Date Reminder!')
  end
end
