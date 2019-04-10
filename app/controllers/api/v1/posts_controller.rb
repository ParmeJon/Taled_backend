class Api::V1::PostsController < ApplicationController

  def index
    @posts = Post.all
    render json: @posts
  end

  def create
    @post = Post.create!(post_params)
    @trip = Trip.all.find(@post.trip_id)
    @user = User.all.find(@trip.user_id)
    if post_params[:post_image] && !@post.post_image.blank?
      @post.post_image.attach(post_params[:post_image])
    end
    # @posts = Post.all.select{|post| post.trip_id === @trip.id}
    # serialized_posts = @posts.map{|post| PostSerializer.new(post)}
    render json: {user: UserSerializer.new(@user), trip: TripSerializer.new(@trip), post: PostSerializer.new(@post)}
  end

  private
    def post_params
      params.permit(:title, :content, :trip_id, :post_image, :geolocation)
    end
end
