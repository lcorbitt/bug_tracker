json.extract! ticket, :id, :title, :user_id, :status, :project_id, :description, :priority, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
