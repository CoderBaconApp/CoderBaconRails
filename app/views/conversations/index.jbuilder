json.conversations do
   json.partial! partial: 'conversations/conversation', collection: @conversations, as: :conversation
end
