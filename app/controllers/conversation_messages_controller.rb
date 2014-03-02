class ConversationMessagesController < ApplicationController

  protect_from_forgery except: :create
  before_filter :authenticate_user!


  def index
    convo = current_user.conversations.where(id: params[:conversation_id]).first
    if convo then @messages = convo.messages else head status: 400 end
  end


  def create
    convo = current_user.conversations.where(id: params[:conversation_id]).first

    if convo
      msg = Message.new(message_params)
      msg.sender = current_user
      convo.messages << msg

      head status: if msg.save and convo.save then 200 else 400 end
    else
      head status: 400
    end
  end


  private

  def message_params
    params.require(:message).permit(:subject, :body)
  end
end
