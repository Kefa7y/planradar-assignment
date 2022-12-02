class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :description
      t.belongs_to :assigned_user_id, null: false, foreign_key: true
      t.date :due_date
      t.integer :status_id
      t.integer :progress

      t.timestamps
    end
  end
end
