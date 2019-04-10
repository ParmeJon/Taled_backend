class TripSerializer < ActiveModel::Serializer
  attributes :id, :title, :completed, :updated_at, :user_id

  has_many :posts
  belongs_to :user
end
