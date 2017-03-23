class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    if message.instance_of? Message
      ActionCable.server.broadcast "chat_rooms_#{message.chat_room.id}_channel",
                                   message: render_message(message),
                                   action: 'post'
    elsif message[:edit_body].present?
      ActionCable.server.broadcast "chat_rooms_#{message[:chat]}_channel",
                                   edit_body: message[:edit_body],
                                   id: message[:id],
                                   action: 'edit'
    elsif message[:update_body].present?
      ActionCable.server.broadcast "chat_rooms_#{message[:chat]}_channel",
                                   update_body: message[:update_body],
                                   action: 'update',
                                   id: message[:id]
    elsif message[:status].present?
      ActionCable.server.broadcast "chat_rooms_#{message[:chat]}_channel",
                                   action: 'delete',
                                   id: message[:id]
    end
  end


  private

  def render_message(message)
    MessagesController.render partial: 'messages/message', locals: {message: message}
  end
end
