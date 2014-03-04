class ConversationsController < ApplicationController
  protect_from_forgery except: :create
  before_filter :authenticate_user!

  def index
    @conversations = current_user.conversations
  end
end
