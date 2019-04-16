class Api::V1::RequestfeedsController < ApplicationController
skip_before_action :authorized, only: [:create]

  def index
    @requestfeeds = Requestfeed.all
    render json: @requestfeeds
  end

  def create
  requestfeed = Requestfeed.new(requestfeed_params)
  if requestfeed.save
    serialized_data = ActiveModelSerializers::Adapter::Json.new(
      RequestfeedSerializer.new(requestfeed)
    ).serializable_hash
    ActionCable.server.broadcast 'requestfeeds_channel', serialized_data
    head :ok
  end
end

private

def requestfeed_params
  params.require(:requestfeed).permit(:title)
end
end
