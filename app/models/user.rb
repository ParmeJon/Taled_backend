class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: {case_sensative: false}
  validates :first_name, :last_name, :email, presence: true

  has_one_attached :profile_image
  has_many :trips, dependent: :destroy
  has_many :posts, through: :trips, dependent: :destroy
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
end
