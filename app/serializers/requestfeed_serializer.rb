class RequestfeedSerializer < ActiveModel::Serializer
  attributes :id, :title
  has_many :friendships
end
