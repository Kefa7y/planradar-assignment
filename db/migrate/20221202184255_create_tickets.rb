# frozen_string_literal: true

class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.belongs_to :assigned_user, null: false, foreign_key: { to_table: :users }
      t.date :due_date
      t.integer :status_id, default: 0
      t.integer :progress, default: 0

      t.timestamps
    end
  end
end
