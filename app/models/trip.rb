class Trip < ApplicationRecord
  belongs_to :trip
  has_many :posts
end
