module MessagesHelper
  def message_popover_direction_class(message)
    "popover #{message.sender == current_user ? 'left' : 'right'}"
  end
end
