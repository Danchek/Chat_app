class ChatRoomsUsersController < ApplicationController
  before_action :set_chat_room_user, only: [:create, :destroy]
  def create
    @chat_room.user << @user
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @chat_room.user.destroy(@user)
    redirect_back(fallback_location: root_path)
  end

  def get_friends_for_chat
    @chat_room = ChatRoom.find(params[:id])
    @users = current_user.friends - @chat_room.user
    render partial: 'friends_for_chat'
  end

  private

  def set_chat_room_user
    @user = User.find(params[:friend_id])
    @chat_room = ChatRoom.find(params[:id])
  end
end
