class TripSerializer < ActiveModel::Serializer
  attributes :id, :title, :user_id, :completed

  has_many :posts
  belongs_to :user
end
