class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: {case_sensative: false}
  validates :first_name, :last_name, :email, presence: true

  has_one_attached :profile_image
  has_many :trips
  has_many :posts, through: :trips
end
