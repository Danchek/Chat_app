class ChatRoom < ApplicationRecord
  has_and_belongs_to_many :user
  has_many :messages, -> { order(:created_at => :asc) }, dependent: :destroy

  validates :chat_type, inclusion: { in: ['private_chat', 'public_chat', 'group_chat'] }
end
