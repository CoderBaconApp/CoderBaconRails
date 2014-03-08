class MessagesController < ApplicationController
  protect_from_forgery except: :create
  before_filter :authenticate_user!

  def index
    @message = Message.new

    if params[:conversation_id].present?
      @conversation = current_user.conversations.find_by_id(params[:conversation_id])

      unless @conversation
        head status: 400
      else
        @form_post_path = conversation_messages_path(@conversation)
      end
    elsif params[:user_id].present?
      other_user = User.find_by_id(params[:user_id])

      #Can't start a conversation with ourself
      if !other_user or other_user == current_user
        head status: 400
      else
        listeners = [current_user, other_user]
        conversation_ids = Listener.select("conversation_id").where(:user_id => listeners).group("conversation_id").having("count(*) = #{listeners.length}").pluck("conversation_id")
        puts "Conversations Ids: #{conversation_ids}"
        if conversation_ids.length == 1
          @conversation = current_user.conversations.find(conversation_ids[0])
        end

        @form_post_path = user_messages_path(other_user)
      end
    end
  end

  def create
    if params[:conversation_id].present?
      conversation = current_user.conversations.find(params[:conversation_id])
    elsif params[:user_id].present?
      other_user = User.find(params[:user_id])

      #Can't start a conversation with ourself
      if other_user == current_user
        head status: 400
      end

      listeners = [current_user, other_user]
      conversation_ids = Listener.select("conversation_id").where(:user_id => listeners).group("conversation_id").having("count(*) = #{listeners.length}").pluck("conversation_id")
        puts "Conversations Ids: #{conversation_ids}"
        if conversation_ids.length == 1
          conversation = current_user.conversations.find(conversation_ids[0])
        else
          conversation = Conversation.new()
          listener1 = Listener.new(user: current_user)
          listener2 = Listener.new(user: other_user)
          conversation.listeners << [listener1, listener2]
        end
    end

    if conversation
      message = Message.new(message_params)
      message.sender = current_user
      conversation.messages << message

      if message.save and conversation.save
        redirect_to action: :index
      else
        head status: 400
      end
    else
      head status: 400
    end
  end

  private

  def message_params
    params.require(:message).permit(:subject, :body)
  end
end
