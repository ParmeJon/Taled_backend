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
