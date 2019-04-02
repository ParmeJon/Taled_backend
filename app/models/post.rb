class Post < ApplicationRecord
  has_many_attached :forms
  belongs_to :trip
end
