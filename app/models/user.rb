# frozen_string_literal: true

class User < ApplicationRecord
  has_many :tickets, dependent: :destroy

  # This is a stub function for more features to come concerning notification channel
  def notification_channel
    'email'
  end
end
