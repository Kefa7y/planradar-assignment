# Mohamed Ashraf's PlanRadar assignment

This application uses SQLite as the main database, Sidekiq as the background task executer and Redis as storage for Sidekiq jobs.
This task is not yet complete. Due to personal reasons, I could not start the task at the scheduled time, which caused the task to be submitted prematurely.

### TODOs:

- Persisting Sidekiq Job ID in the Ticket model for notification state changes after a notification has been scheduled. Under this task lies 3 cases to be handled and tested;
  - Changing user notification preferences after a notification has already been scheduled
  - Changing ticket due date after a notification has already been scheduled
  - Deleting ticket after a notification has already been scheduled
-
- Finish writing unit tests
- Adding Integration tests
- Enhance README (more info about the code and how it operates)

### Running the code:

This code requires 3 things to run in parallel to operate correctly: Rails Application, Sidekiq and Redis

- Running Rails: `rails s`
- Running Sidekiq: `bundle exec sidekiq`
- Running Redis: `docker-compose up -d`

### Running the tests:

This codebase uses rspec as it's testing infrastructure basis. Rake is configured to run the tests automatically when invoked. To run the tests, just run `rake`.
You will find the test coverage report in the `coverage` directory in the root of this project.

### Mailing notes:

Action Mailer is configured differently for each current active environment. Here, you will find the expected behavior for action mailer per environment

- test: Stub emails with `delivery_method: :test`
- development: Stub emails with `delivery_method: :file`, where you can see all the delivered emails in the `tmp/mails` directory
- production: Sends email using SMTP. Take note that the current SMTP settings in production are not yet placed due to not knowing the nature of the intended production SMTP provider. In order for the emails to work properly in production, please set production `config.action_mailer.smtp_settings`
