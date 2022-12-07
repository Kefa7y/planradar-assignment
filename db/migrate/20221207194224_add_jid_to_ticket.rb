# frozen_string_literal: true

class AddJidToTicket < ActiveRecord::Migration[6.1]
  def change
    add_column :tickets, :jid, :string, limit: 40
  end
end
