class FriendshipsChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    requestfeed = Requestfeed.find(params[:requestfeed])
    stream_for requestfeed
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
