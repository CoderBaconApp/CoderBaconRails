class ConversationsController < ApplicationController
  protect_from_forgery except: :create
  before_filter :authenticate_user!

  def index
    current_user.conversations
  end

  def create
    convo = Conversation.new
    users = listener_params[:user_id].collect { |id| User.find id }

    if users and users.count > 1
      convo.users << users
      convo.save!
      head status: 200
    else
      head status: 400
    end
  end

  private

  def listener_params
    params.require(:listener).permit(user_id: [])
  end
end
