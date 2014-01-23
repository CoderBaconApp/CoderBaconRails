class MessagesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @sent_messages = current_user.sent_messages
    @received_messages = current_user.received_messages
  end

end
