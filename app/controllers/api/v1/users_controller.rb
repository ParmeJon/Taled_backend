class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def profile
    render json: {user: UserSerializer.new(current_user)}, status: :accepted
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      token = encode_token({user_id: @user.id})
      render json: {user: UserSerializer.new(@user), jwt: token }, status: :created
    else
      render json: { error: 'failed to create user' }, status: :not_acceptable
  end

  def show
    jwt = request.headers['Authorization']
    without = jwt.split('Bearer ')
    id = JWT.decode(without[1], "hello")[0]["user_id"]
    @user = User.find(id)
    render json: @user
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :status)
  end
end
