class FriendshipSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :friend_id, :approve_status

  # has_many_attached :forms, dependent: :destroy
end
