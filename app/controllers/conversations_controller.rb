class ConversationsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @conversations = current_user.conversations
  end
end
