class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :active, :profile_image, :trips, :posts


  def profile_image
    if self.object.profile_image.attached?
    {
      image_url: self.object.profile_image.blob.service_url
    }
    end
  end

  # has_one_attached :profile_image, dependent: :destroy
  has_many :trips
  has_many :posts, through: :trips
  # has_many_attached :forms, through: :posts, dependent: :destroy
end
