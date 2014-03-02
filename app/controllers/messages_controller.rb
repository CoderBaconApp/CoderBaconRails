class MessagesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @sent_messages = current_user.sent_messages
  end

  def new
    @users = User.where.not(id: current_user)
    @message = current_user.sent_messages.new
  end

  def create
    # Find or create a conversation
    current_user.conversations.include(:users).where("user.id": message_params[:receiver_id])

    @message = Message.new(message_params)
    @message.sender = current_user
    @message.save!
    flash.notice = "Message successfully created"
    redirect_to :back
  end

  private
  def message_params
    params.require(:message).permit(:subject, :body, :receiver_id)
  end

end
