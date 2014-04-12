class ConversationFinder
  def self.with_listeners listeners
    convos = Listener.where(:user_id => listeners).group("conversation_id")
        .having("count(*) = #{listeners.length}").pluck("conversation_id")

    raise "More than one convo with same set of listeners" if convos.length > 1

    if convos.length == 1
      Conversation.find_by_id convos.first
    else nil end
  end

  def self.find_or_build listeners
    conversation = ConversationFinder.with_listeners(listeners)

    unless conversation
      conversation = Conversation.new
      conversation.listeners << listeners.collect do |listener|
        Listener.new(user: listener)
      end
    end

    conversation
  end
end
