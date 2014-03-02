json.conversations do
   json.partial! partial: 'conversations/conversation', collection: @convos, as: :conversation
end
