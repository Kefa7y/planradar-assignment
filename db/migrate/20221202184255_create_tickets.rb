# frozen_string_literal: true

class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :description
      t.belongs_to :assigned_user, null: false, foreign_key: { to_table: :users }
      t.date :due_date
      t.integer :status_id
      t.integer :progress

      t.timestamps
    end
  end
end
