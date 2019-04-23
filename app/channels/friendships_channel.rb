class FriendshipsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "friendships_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
