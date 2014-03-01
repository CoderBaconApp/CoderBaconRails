class MessagesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @sent_messages = current_user.sent_messages
    @received_messages = current_user.received_messages

    # @sent_conversations = current_user.sent_messages.select("MAX(id) AS id").select("receiver_id").group(:receiver_id).collect { |x| [x.id, x.receiver_id] }
    # @received_conversations = current_user.received_messages.select("MAX(id) AS id").select("sender_id").group(:sender_id).collect { |x| [x.id, x.sender_id] }

    # @sent_conversations.zip(@received_conversations).collect do  |arr|
    #   sent = arr[0]
    #   received = arr[1]

    #   if sent[0] > received[0]
    #     return sent[0]
    #   else
    #     return received[0]
    #   end
    # end

  end

  def new
    @users = User.all
    @message = current_user.sent_messages.new
  end

  def create
    @message = Message.new(message_params)
    @message.sender = current_user
    @message.save!
    render index
  end

  private
  def message_params
    params.require(:message).permit(:subject, :body, :receiver_id)
  end

end
