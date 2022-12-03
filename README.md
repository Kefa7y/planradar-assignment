# Mohamed Ashraf's PlanRadar assignment

Mailing notes:
Action Mailer is configured differently for each current active environment. Here, you will find the expected behavior for action mailer per environment
test: Stub emails with `delivery_method: :test`
development: Stub emails with `delivery_method: :file`, where you can see all the delivered emails in the `tmp/mails` directory
production: Sends email using SMTP. Take note that the current SMTP settings in production are not yet placed due to not knowing the nature of the intended production SMTP provider. In order for the emails to work properly in production, please set production `config.action_mailer.smtp_settings`

Cases not handled:
Changing user notification preferences after a notification has already been scheduled
