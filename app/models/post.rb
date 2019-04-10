class Post < ApplicationRecord
  has_one_attached :post_image
  belongs_to :trip
end
