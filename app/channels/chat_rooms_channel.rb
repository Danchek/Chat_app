class ChatRoomsChannel < ApplicationCable::Channel

  def subscribed
    stream_from "chat_rooms_#{params['chat_room_id']}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    current_user.messages.create!(body: data['message'], chat_room_id: data['chat_room_id'])
  end

  def edit_message(data)
    @message = Message.find(data['message_id'])
    if current_user.id == @message.user.id
      MessageBroadcastJob.perform_later(chat: @message.chat_room.id,
                                        edit_body: @message.body,
                                        id: @message.id)
    end
  end

  def update_message(data)
    @message = Message.find(data['message_id'])
    @message.update!(body: data['message']) if current_user.id == @message.user.id
  end

  def delete_message(data)
    @message = Message.find(data['message_id'])
    @message.destroy if current_user.id == @message.user.id
  end

end
