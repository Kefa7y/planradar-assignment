# frozen_string_literal: true

user1 = User.create(name: 'Mohamed', mail: 'mohamed.ash.roshdy@outlook.com', send_due_date_reminder: true,
                    due_date_reminder_interval: 0, due_date_reminder_time: '8:00', time_zone: 'Cairo')

user2 = User.create(name: 'Ashraf', mail: 'mohamed.ash.roshdy@gmail.com', send_due_date_reminder: false,
                    due_date_reminder_interval: 0, due_date_reminder_time: '9:00', time_zone: 'Europe/Vienna')

Ticket.create(title: 'Mohamed Ticket', description: 'This is Mohamed\'s Ticket', assigned_user_id: user1.id,
              due_date: Date.tomorrow, status_id: 0, progress: 50)

Ticket.create(title: 'Ashraf Ticket', description: 'This is Ashraf\'s Ticket', assigned_user_id: user2.id,
              due_date: Date.yesterday, status_id: 1, progress: 90)
