class MessagesController < ApplicationController
  protect_from_forgery except: :create
  before_filter :authenticate_user!

  def index
    @convo = current_user.conversations.where(id: params[:conversation_id]).first
    if @convo then @messages = @convo.messages else head status: 400 end
    @message = Message.new
  end

  def create
    convo = current_user.conversations.where(id: params[:conversation_id]).first

    if convo
      msg = Message.new(message_params)
      msg.sender = current_user
      convo.messages << msg

      if msg.save and convo.save
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
