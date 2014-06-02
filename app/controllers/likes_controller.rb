class LikesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    like = @post.likes.new
    like.user = current_user
    if like.save!
      WebsocketRails[:likes].trigger 'like', {id: @post.id, new_like_count: @post.likes.count}
      render 'create', formats: [:json] 
    else
      redirect_to '/posts'
    end
  end

  def destroy
    @like = Like.where(:post => params[:post_id], :user => current_user)
    @post = Post.find(params[:post_id])
    if @like.any?
      @like.first.destroy
      WebsocketRails[:unlikes].trigger 'unlike', {id: @post.id, new_like_count: @post.likes.count}
      render 'destroy', formats: [:json] 
    else
      redirect_to '/posts'
    end
  end
end
