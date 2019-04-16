class FriendshipSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :friend_id, :requestfeed_id, :approve_status, :created_at

  # has_many_attached :forms, dependent: :destroy
end
