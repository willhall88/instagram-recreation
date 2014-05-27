class LikesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    like = @post.likes.new
    like.user = current_user
    if like.save
      redirect_to '/posts'
    else
      raise 'hello'
    end
  end

  def destroy
    @like = Like.where(:post => params[:post_id], :user => current_user).first
    @like.destroy

    redirect_to '/posts'
  end
end
