class Message < ActiveRecord::Base
  belongs_to :sender, :class_name => 'User'
  belongs_to :conversation

  def self.new_for_user(user, message_params)
    message = Message.new message_params
    message.sender = user
    message
  end
end
