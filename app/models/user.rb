class User < ApplicationRecord
  has_friendship
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :chat_rooms, dependent: :destroy
  has_many :messages, dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  validates :nickname, presence: true
  validates :sex, inclusion: { in: ['', 'Female', 'Male'] }

  def name
    email.split('@')[0]
  end

  def self.all_except(user)
    excluded_users = HasFriendship::Friendship.where(friendable_id: user.id)
                       .pluck(:friend_id)
    User.where.not(id: [excluded_users, user.id].flatten)
  end


end
