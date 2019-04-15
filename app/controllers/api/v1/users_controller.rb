class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

  # def image_url
  # Rails.application.routes.url_helpers.rails_blob_path(self.profile_image, only_path: true)
  # end

  def profile
    render json: {user: UserSerializer.new(current_user)}, status: :accepted
  end

  def users_list
    @users = User.all
    @serialized_user = @users.map{|user| UserListSerializer.new(user)}
    render json: {users: @serialized_user}
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      @token = encode_token({user_id: @user.id})
      render json: {user: UserSerializer.new(@user), jwt: @token }, status: :created
    else
      render json: { error: 'failed to create user' }, status: :not_acceptable
    end
  end

  def show
    jwt = request.headers['Authorization']
    without = jwt.split('Bearer ')
    id = JWT.decode(without[1], "pl34s3")[0]["user_id"]
    @user = User.find(id)
    render json: {user: UserSerializer.new(@user), trips: TripSerializer.new(@user.trips)}
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)

    if user_params[:profile_image] && !@user.profile_image.blank?
      @user.profile_image.attach(user_params[:profile_image])
    end

    if @user.valid?
      render json: {user: UserSerializer.new(@user) }, status: :updated
    else
      render json: {error: 'failed to update user'}, status: :not_acceptable
    end
  end

  # def update
  #   jwt = request.headers['Authorization']
  #   without = jwt.split('Bearer ')
  #   id = JWT.decode(without[1], "pl34s3")[0]["user_id"]
  #   @user = User.find(id)
  #   render json: {user: UserSerializer.new(@user)}
  # end

  private
  def user_params
    params.permit(:email, :first_name, :last_name, :password, :active, :profile_image)
  end
end
