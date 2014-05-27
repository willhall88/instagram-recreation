class LikesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    like = @post.likes.new
    like.user = current_user
    like.save
    redirect_to '/posts'
  end

  def destroy
    @like = Like.where(:post => params[:post_id], :user => current_user)
    @like.first.destroy if @like.any?
    redirect_to '/posts'
  end
end
