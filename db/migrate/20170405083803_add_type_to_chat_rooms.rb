class AddTypeToChatRooms < ActiveRecord::Migration[5.1]
  def change
    add_column :chat_rooms, :chat_type, :string
  end
end
