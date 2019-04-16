class Api::V1::TripsController < ApplicationController

  def create
    @trip = Trip.create!(trip_params)
    @user = User.all.find(trip_params[:user_id])
    render json: {user: UserSerializer.new(@user), trip: TripSerializer.new(@trip)}, status: :accepted
  end

  def destroy

    @trip = Trip.destroy(params[:id])
    @user = User.all.find(@trip.user_id)
    render json: {user: UserSerializer.new(@user)}
  end

  def show
    @trip = Trip.find(params[:id])
    jwt = request.headers['Authorization']
    without = jwt.split('Bearer ')
    id = JWT.decode(without[1], ENV['SECRET_TOKEN'])[0]["user_id"]
    if id === @trip.user_id
      render json: {trip: TripSerializer.new(@trip)}
    else
      render json: { message: 'Invalid user for trip'}, status: :unauthorized
    end
  end

  def current_trip
    jwt = request.headers['Authorization']
    without = jwt.split('Bearer ')
    id = JWT.decode(without[1], ENV['SECRET_TOKEN'])[0]["user_id"]
    @trips = Trip.select{|trip| trip.user_id === 1 && !trip.completed }
    render json: {trip: TripSerializer.new(@trips.last)}

  end

  def update
    @trip = Trip.find(params[:id])
    @trip.update(trip_params)
    @user = User.all.find(@trip.user_id)
    render json: {user: UserSerializer.new(@user)}
  end

  private
  def trip_params
    params.permit(:completed, :title, :user_id)
  end
end
