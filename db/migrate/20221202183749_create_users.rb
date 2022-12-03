# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :mail, null: false
      t.boolean :send_due_date_reminder, default: true
      t.integer :due_date_reminder_interval, default: 0
      t.time :due_date_reminder_time
      t.string :time_zone, limit: 60
    end

    add_index :users, [:mail], unique: true
  end
end
