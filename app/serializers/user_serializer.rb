class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :status

  has_many :trips
  has_many :posts, through: :trips
end
