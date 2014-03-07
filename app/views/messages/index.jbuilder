json.conversation do
   json.create_message_url conversation_messages_url(@conversation)

   json.listeners do
      json.partial! @conversation.users - [current_user], partial: 'users/user', as: :user
   end

   json.messages do
      json.partial! partial: 'messages/message', collection: @conversation.messages, as: :message
   end
end
