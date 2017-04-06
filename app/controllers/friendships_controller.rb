class FriendshipsController < ApplicationController
  before_action :find_friend, only: [:add_friend, :change_request_status,
                                     :remove_friend, :unblock_friend]

  def find
    @users = User.all_except(current_user)
  end

  def friends
    @users = current_user.friends
  end

  def add_friend_to_chat
    friends = current_user.friends
    chat_room = ChatRoom.find(params[:id])
    @users = friends - chat_room.user
    render partial: 'friendships/friends_for_chat'
  end

  def add_friend
    current_user.friend_request(@friend)
    redirect_back(fallback_location: root_path)
  end

  def remove_friend
    current_user.remove_friend(@friend)
    redirect_back(fallback_location: root_path)
  end

  def pending_requests
    @users = current_user.requested_friends
  end

  def user_request
    @users = current_user.pending_friends
  end

  def change_request_status
    if params[:btn_accept]
      current_user.accept_request(@friend)
    elsif params[:btn_decline]
      current_user.decline_request(@friend)
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def find_friend
    @friend = User.find(params[:friend_id])
  end
end
