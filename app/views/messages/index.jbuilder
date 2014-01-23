json.received do 
  json.partial! partial: 'messages/message', collection: @sent_messages, as: :message
end

json.sent do
  json.partial! partial: 'messages/message', collection: @received_messages, as: :message
end