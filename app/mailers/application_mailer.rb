# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'info@planradar.com'
  layout 'mailer'
end
