class Conversation < ActiveRecord::Base
  has_many :listeners
  has_many :users, through: :listeners
  has_many :messages

  def last_message
    messages.order("created_at desc").first || Message.new
  end

  def listener_emails except = []
    (users - except).map { |user| user.email }.join(", ")
  end
end
