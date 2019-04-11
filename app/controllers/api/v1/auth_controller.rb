require 'dotenv/load'

class Api::V1::AuthController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    @user = User.find_by(email: user_login_params[:email])
    if @user && @user.authenticate(user_login_params[:password])
      token = encode_token({user_id: @user.id})
      render json: {user: UserSerializer.new(@user), jwt: token}, status: :accepted
    else
      render json: { message: 'Invalid username or password'}, status: :unauthorized
    end
  end

  def show
    jwt = request.headers['Authorization']
    without = jwt.split('Bearer ')
    id = JWT.decode(without[1], ENV['SECRET_TOKEN'])[0]["user_id"]
    @user = User.find(id)
    render json: {user: UserSerializer.new(@user)}
  end


  private

  def user_login_params
    params.permit(:email, :password)
  end
end
