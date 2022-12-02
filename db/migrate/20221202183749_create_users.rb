# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :mail
      t.integer :send_due_date_reminder, limit: 10
      t.integer :due_date_reminder_interval
      t.time :due_date_reminder_time
      t.string :time_zone, limit: 60
    end
  end
end
