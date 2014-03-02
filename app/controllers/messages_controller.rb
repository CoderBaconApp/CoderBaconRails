class MessagesController < ApplicationController
  protect_from_forgery except: create
  before_filter :authenticate_user!

  def index
    @sent_messages = current_user.sent_messages
  end

  def new
    @users = User.where.not(id: current_user)
    @message = current_user.sent_messages.new
  end

  def create
    convo = Conversation.new

    @message = Message.new(message_params)
    @message.sender = current_user
    @message.save!

    convo.messages << @message

    convo.users << current_user
    convo.users << User.find message_params[:receiver_id]

    convo.save!

    flash.notice = "Message successfully created"
    redirect_to :back
  end

  private
  def message_params
    params.require(:message).permit(:subject, :body, :receiver_id)
  end

end
