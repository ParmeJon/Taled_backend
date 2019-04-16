class RequestfeedsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "requestfeeds_channel"
  end

  # def send_friendrequest(data)
  #
  #   request = Friendship.create(body: data['request'])
  #   socket = { request: request.body }
  #   RequestfeedsChannel.broadcast_to('requestfeeds_channel', socket)
  # end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
