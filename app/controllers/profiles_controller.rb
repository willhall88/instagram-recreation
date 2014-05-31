class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @posts = Post.all
    @user = User.find_by(username: params[:id])
    @comment = Comment.new
  end

end