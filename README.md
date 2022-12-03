# Mohamed Ashraf's PlanRadar assignment

This application uses SQLite as the main database, Sidekiq as the background task executer and Redis as storage for Sidekiq jobs.
This task is not yet complete.

TODOs:
Changing user notification preferences after a notification has already been scheduled
Changing ticket due date after a notification has already been scheduled
Deleting ticket after a notification has already been scheduled
Enhance README
Finish writing tests

Running the code:
This code requires 3 things to run in parallel to operate correctly: Rails Application, Sidekiq and Redis
Run Rails: `rails s`
Run Sidekiq: `bundle exec sidekiq`
Run Redis: `docker-compose up -d`

Mailing notes:
Action Mailer is configured differently for each current active environment. Here, you will find the expected behavior for action mailer per environment
test: Stub emails with `delivery_method: :test`
development: Stub emails with `delivery_method: :file`, where you can see all the delivered emails in the `tmp/mails` directory
production: Sends email using SMTP. Take note that the current SMTP settings in production are not yet placed due to not knowing the nature of the intended production SMTP provider. In order for the emails to work properly in production, please set production `config.action_mailer.smtp_settings`
