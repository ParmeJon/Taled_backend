class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :active

  # has_one_attached :profile_image, dependent: :destroy
  has_many :trips, dependent: :destroy
  has_many :posts, through: :trips, dependent: :destroy
  # has_many_attached :forms, through: :posts, dependent: :destroy
end
