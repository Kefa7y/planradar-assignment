# Mohamed Ashraf's PlanRadar assignment

This application uses SQLite as the main database, Sidekiq as the background task executer and Redis as storage for Sidekiq jobs.
This application relies on the usage of Active Record Callbacks for the core requirements. I have tried as much as possible to stay withing the defined database schema attached
in the task description, but I have added the `jid` field in the Ticket model as a part of the task.

### Running the code:

This code requires 3 components to run in parallel to operate correctly: Rails Application, Sidekiq and Redis. Preferably, the components should run in the following order:

- Running Redis in daemon mode using docker-compose: `docker-compose up -d`
- Running Rails: `rails s`
- Running Sidekiq: `bundle exec sidekiq`

### API Usage:

You will find an `Insomnia.json` Insomnia V4 JSON file file in this repo, which contains an exported version of the Insomnia collection used to test this API.

### Running the tests:

This codebase uses rspec as it's testing infrastructure basis. Rake is configured to run the tests automatically when invoked. To run the tests, just run `rake`.
You will find the test coverage report in the `coverage` directory in the root of this project.

### Mailing notes:

Action Mailer is configured differently for each current active environment. Here, you will find the expected behavior for action mailer per environment

- test: Stub emails with `delivery_method: :test`
- development: Stub emails with `delivery_method: :file`, where you can see all the delivered emails in the `tmp/mails` directory
- production: Sends email using SMTP. Take note that the current SMTP settings in production are not yet placed due to not knowing the nature of the intended production SMTP provider. In order for the emails to work properly in production, please set production `config.action_mailer.smtp_settings`

### Possible Enhancements:

- Adding Integration tests
- Adding an integrated API documentation tool (i.e. Swagger UI) to act as a reference for the API
- Cleaning code and improving code structure
- Revisit tests to make sure they are consistent in writing
- Writing a Dockerfile and moving Sidekiq (and possiblty the Rails application) inside the docker-compose file
