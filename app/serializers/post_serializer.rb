class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :trip_id, :geolocation, :post_images

  # has_many_attached :forms, dependent: :destroy
  belongs_to :trip
end
