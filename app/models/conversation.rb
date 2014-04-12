class Conversation < ActiveRecord::Base
  has_many :listeners
  has_many :users, through: :listeners
  has_many :messages

  validate :duplicate_conversations


  def last_message
    messages.order("created_at desc").first || Message.new
  end

  def listener_emails except = []
    (users - except).map { |user| user.email }.join(", ")
  end

  def duplicate_conversations
    if ConversationFinder.with_listeners listeners
      errors.add :listeners, "A duplicate conversation already exists"
    end
  end
end
