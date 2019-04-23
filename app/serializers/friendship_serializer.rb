class FriendshipSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :friend_id, :approve_status, :created_at, :message, :friend, :user

  # has_many_attached :forms, dependent: :destroy
  belongs_to :friend
  belongs_to :user
end
