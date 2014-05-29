class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @posts = Post.all
    @user = current_user
    @comment = Comment.new
  end

end