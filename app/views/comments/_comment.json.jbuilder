json.extract! comment, :id, :user_id, :message, :commented_on_type, :commented_on_id, :created_at, :updated_at
json.url comment_url(comment, format: :json)
