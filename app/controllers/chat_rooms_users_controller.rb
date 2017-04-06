class ChatRoomsUsersController < ApplicationController
  before_action :set_chat_room_user
  def create
    @chat_room.user << @user
    render layout: false
  end

  def destroy
    @chat_room.user.destroy(@user)
    render layout: false
  end

  private


  def set_chat_room_user
    @user = User.find(params[:friend_id])
    @chat_room = ChatRoom.find(params[:chat_id])
  end
end
