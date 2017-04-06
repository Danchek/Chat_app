class ChatRoomsUser < ApplicationRecord
  belongs_to :chat_room, dependent: :destroy
  belongs_to :user, dependent: :destroy
end
