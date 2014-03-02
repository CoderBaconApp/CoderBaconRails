json.conversation do
   json.create_message_url conversation_messages_url(@convo)

   json.listeners do
      json.partial! @convo.users - [current_user], partial: 'users/user', as: :user
   end

   json.messages do
      json.partial! partial: 'messages/message', collection: @messages, as: :message
   end
end
