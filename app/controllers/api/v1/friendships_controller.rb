class Api::V1::FriendshipsController < ApplicationController

  def index
    @friendships = Friendship.all
    render json: @friendships
  end

  def create
    @friendship = Friendship.new(friendship_params)
    requestfeed = Requestfeed.find(friendship_params[:requestfeed_id])

    if @friendship.save
      serialized_data = ActiveModelSerializers::Adapter::Json.new(
        FriendshipSerializer.new(@friendship)
      ).serializable_hash
      FriendshipsChannel.broadcast_to requestfeed, serialized_data
      head :ok
    end

    # @sent_requests = Friendship.all.find_by(user_id: @friendship.user_id )
    # @pending_requests = @sent_requests.select{|request| !request.approve_status}
    # render json: @pending_requests
  end

  def destroy

  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.update(friendship_params)
    render json: @friendship

  end




  private
  def friendship_params
    params.require(:friendship).permit(:id, :friend_id, :approve_status, :user_id, :requestfeed_id)
  end
end
