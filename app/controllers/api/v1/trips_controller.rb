class Api::V1::TripsController < ApplicationController

  def create
    @trip = Trip.create!(trip_params)
    render json: {user: TripSerializer.new(@trip)}, status: :accepted
  end

  private
  def trip_params
    params.permit(:completed, :title, :user_id)
  end
end
