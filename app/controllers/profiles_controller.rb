class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find_by(username: params[:id])
    @posts = @user.posts
    @comment = Comment.new
  end

end