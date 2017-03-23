class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room
  validates :body, presence: true, length: {minimum: 2, maximum: 1000}
  after_create_commit { MessageBroadcastJob.perform_later(self) }
  after_update_commit {
    MessageBroadcastJob.perform_later(chat: self.chat_room.id,
                                      update_body: self.body,
                                      id: self.id)
  }
  after_destroy_commit {
    MessageBroadcastJob.perform_later(status: 'deleted',
                                      chat: self.chat_room.id,
                                      id: self.id)
  }

  def timestamp
    created_at.strftime('%H:%M:%S %d %B %Y')
  end
end


