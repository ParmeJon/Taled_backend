class Api::V1::FriendshipsController < ApplicationController

  def create
    @friendship = Friendship.create!(friendship_params)
    @sent_requests = Friendship.all.find_by(user_id: @friendship.user_id )
    @pending_requests = @sent_requests.select{|request| !request.approve_status}
    render json: @pending_requests
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
    params.permit(:id, :friend_id, :approve_status, :user_id)
  end
end
