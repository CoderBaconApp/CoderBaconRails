json.listeners do
   json.partial! 'users/user', collection: conversation.users - [current_user], as: :user
end

json.first_message do
   first_msg = conversation.messages.order("id desc").first
   json.partial! 'messages/message', message: first_msg if first_msg
end
