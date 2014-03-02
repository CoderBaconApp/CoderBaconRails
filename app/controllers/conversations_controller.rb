class ConversationsController < ApplicationController
  protect_from_forgery except: :create
  before_filter :authenticate_user!

  def index
    @conversations = current_user.conversations
  end

  def show
    redirect_to conversation_messages_path(params[:id])
  end

  def new
    @users = User.where.not(id: current_user)
    @message = Message.new
  end

  def create
    convo = Conversation.new
    users = listener_params[:user_id].collect { |id| User.find id }

    if users and users.count > 1
      message = Message.new(message_params)
      message.sender = current_user
      message.save!

      convo.messages << message
      convo.users << users

      convo.save!
    else
      head status: 400
    end
  end


  private

  def listener_params
    params.require(:listener).permit(user_id: [])
  end

  def message_params
    params.require(:message).permit(:subject, :body)
  end
end
