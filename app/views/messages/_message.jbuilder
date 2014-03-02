json.(message, :id, :sender_id, :subject, :body, :read, :created_at, :updated_at)

json.sender do
  json.partial! 'users/user', user: message.sender
end
