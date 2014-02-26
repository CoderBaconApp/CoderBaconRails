class MessagesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @sent_messages = current_user.sent_messages
    @received_messages = current_user.received_messages
  end

  def new
    @users = User.all
    @message = current_user.sent_messages.new
  end

  def create
    @message = Message.new(message_params)
    @message.sender = current_user
    # @message.receiver = User.find(:receiver)
    @message.save!
  end

  private
  def message_params
    params.require(:message).permit(:subject, :body, :receiver_id)
  end

end
