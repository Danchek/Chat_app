class FriendsController < ApplicationController
  before_action :find_friend, only: :destroy

  def index
    @users = current_user.friends
  end

  def new
    @users = User.all_except(current_user)
  end

  def destroy
    current_user.remove_friend(@friend)
    redirect_back(fallback_location: root_path)
  end

  private

  def find_friend
    @friend = User.find(params[:friend_id])
  end
end
