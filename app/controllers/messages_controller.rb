class MessagesController < ApplicationController
  protect_from_forgery except: :create
  before_filter :authenticate_user!

  def index
    @message = Message.new

    if params[:conversation_id].present?
      @conversation = current_user.conversations.find_by_id(params[:conversation_id])
      render_404 unless @conversation

      #TODO: refactor create to create a new convo on /conversation/messages
      @form_post_path = conversation_messages_path(@conversation)

    elsif params[:user_id].present? and other_user = User.friendly.find(params[:user_id])
      render_404 if other_user.id == current_user.id
      @conversation = ConversationFinder.with_listeners [current_user, other_user]
      @receiver = other_user
      @form_post_path = user_messages_path(other_user)
    else
      render_404
    end

    @messages = @conversation.messages.paginate(page: params[:page]) if @conversation
  end

  def create
    conversation = if params[:conversation_id].present?
      current_user.conversations.find(params[:conversation_id])
    elsif params[:user_id].present?
      ConversationFinder.find_or_build [current_user, User.friendly.find(params[:user_id])]
    end

    render_404 unless conversation

    conversation.messages << Message.new_for_user(current_user, message_params)

    if conversation.save
      redirect_to conversation_messages_path(conversation)
    else
      render_404
    end
  end

  private

  def message_params
    params.require(:message).permit(:subject, :body)
  end
end
