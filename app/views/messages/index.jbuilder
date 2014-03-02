json.conversation do
   json.messages do
      json.partial! partial: 'messages/message', collection: @messages, as: :message
   end
end
