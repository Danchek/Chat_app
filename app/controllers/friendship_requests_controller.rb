class FriendshipRequestsController < ApplicationController
  before_action :find_friend, only: [:create, :update]

  def index
    @users = if params[:pending]
               current_user.requested_friends
             else
               current_user.pending_friends
             end
  end

  def create
    current_user.friend_request(@friend)
    redirect_back(fallback_location: root_path)
  end

  def update
    if params[:btn_accept]
      current_user.accept_request(@friend)
    elsif params[:btn_decline]
      current_user.decline_request(@friend)
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def find_friend
    @friend = User.find(params[:id])
  end
end
