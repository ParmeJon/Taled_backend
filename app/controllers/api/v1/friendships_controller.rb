class Api::V1::FriendshipsController < ApplicationController

  def index
    @friendships = Friendship.all.select{|friendship| !friendship.approve_status}
    jwt = request.headers['Authorization']
    without = jwt.split('Bearer ')
    id = JWT.decode(without[1], ENV['SECRET_TOKEN'])[0]["user_id"]
    @user = User.find(id)
    @filteredFriendships = @friendships.select{|friendship| friendship.friend_id === id}
    render json: @filteredFriendships
  end

  def create
    # logic to find that specific friend request if clicked.
    if Friendship.all.find_by(friend_id: friendship_params[:friend_id], user_id: friendship_params[:user_id])
      old_friendship = Friendship.all.find_by(friend_id: friendship_params[:friend_id], user_id: friendship_params[:user_id])
      serialized_data = ActiveModelSerializers::Adapter::Json.new(
        FriendshipSerializer.new(old_friendship)
      ).serializable_hash
      ActionCable.server.broadcast 'friendships_channel', serialized_data
       head :ok
    else
# makes new friend request and broadcast it back
    friendship = Friendship.new(friendship_params)
      if friendship.save
        serialized_data = ActiveModelSerializers::Adapter::Json.new(
          FriendshipSerializer.new(friendship)
        ).serializable_hash
        ActionCable.server.broadcast 'friendships_channel', serialized_data
         head :ok
      end
    end


    # @sent_requests = Friendship.all.find_by(user_id: @friendship.user_id )
    # @pending_requests = @sent_requests.select{|request| !request.approve_status}
    # render json: @pending_requests
  end

  def destroy

  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.update(approve_status: true)
    @inverse_friendship = Friendship.create(friend_id: @friendship.user_id, user_id: @friendship.friend_id, approve_status: true)

    jwt = request.headers['Authorization']
    without = jwt.split('Bearer ')
    id = JWT.decode(without[1], ENV['SECRET_TOKEN'])[0]["user_id"]
    @user = User.find(id)
    @friendships = Friendship.all.select{|friendship| !friendship.approve_status}
    @filteredFriendships = @friendships.select{|friendship| friendship.friend_id === id}
    render json: {filteredFriendships: @filteredFriendships, user: UserSerializer.new(@user)}

  end




  private
  def friendship_params
    params.require(:friendship).permit(:id, :friend_id, :approve_status, :user_id, :message)
  end
end
