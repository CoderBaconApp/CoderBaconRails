json.(message, :id, :sender_id, :subject, :body, :read, :created_at, :updated_at)

json.sender do 
  json.(message.sender, :id, :email)
end
