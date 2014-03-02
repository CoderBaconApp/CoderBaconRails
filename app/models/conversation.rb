class Conversation < ActiveRecord::Base
  has_and_belongs_to_many :users, join_table: :listeners
  has_many :messages

  def last_message
    messages.order("created_at desc").first
  end
end
