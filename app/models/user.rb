class User < ApplicationRecord
  has_friendship
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_and_belongs_to_many :chat_rooms
  has_many :messages, dependent: :destroy

  has_attached_file :avatar, styles: { medium: "300x300#", thumb: "100x100#" }, default_url: 'default-avatar.png'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  validates :nickname, presence: true
  validates_uniqueness_of :nickname, :email

  def name
    email.split('@')[0]
  end

  protected

  def self.all_except(user)
    excluded_users = HasFriendship::Friendship.where(friendable_id: user.id)
                       .pluck(:friend_id)
    User.where.not(id: [excluded_users, user.id].flatten)
  end


end
