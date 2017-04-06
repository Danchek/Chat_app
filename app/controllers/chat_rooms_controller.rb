class ChatRoomsController < ApplicationController
  load_and_authorize_resource
  before_action :set_chat_room, only: [:edit, :delete, :add_user_to_chat]
  def index
    @chat_rooms = ChatRoom.all
  end

  def new
    @chat_room = ChatRoom.new
  end

  def create
    @chat_room = current_user.chat_rooms.build(chat_room_params)
    if @chat_room.save
      @chat_room.user << current_user
      flash[:success] = 'Chat room added!'
      redirect_to chat_rooms_path
    else
      render 'new'
    end
  end

  def show
    @chat_room = ChatRoom.includes(:messages).find_by(id: params[:id])
    @message = Message.new
  end

  def edit
  end

  def update
    if @chat_room.update(chat_room_params)
      flash[:success] = 'Chat room updated'
      redirect_to chat_rooms_path
    else
      redirect_to @chat_room
    end
  end

  def delete
    @chat_room.destroy
    redirect_back(fallback_location: root_path)
  end

  def add_user_to_chat
    @user = User.find(params[:id])
    @chat_room.user << @user
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:title, :chat_type)
  end

  def set_chat_room
    @chat_room = ChatRoom.find(params[:id])
  end
end
