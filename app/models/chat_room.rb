class ChatRoom < ApplicationRecord
  belongs_to :user
  has_many :messages, -> { order(:created_at => :asc) }, dependent: :destroy

  validates :chat_type, inclusion: { in: %w(private_chat public_chat group_chat) }
end
