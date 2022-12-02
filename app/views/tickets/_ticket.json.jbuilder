json.extract! ticket, :id, :title, :description, :assigned_user_id, :due_date, :status_id, :progress, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
