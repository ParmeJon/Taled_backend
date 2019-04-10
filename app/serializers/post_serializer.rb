class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :geolocation, :updated_at, :post_image, :trip_id


  def post_image
    if self.object.post_image.attached?
    {
      image_url: self.object.post_image.blob.service_url
    }
    end
  end
  # has_many_attached :forms, dependent: :destroy
  belongs_to :trip
end
