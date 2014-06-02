class LikesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    like = @post.likes.new
    like.user = current_user
    if like.save!
      render 'create', formats: [:json] 
    else
      redirect_to '/posts'
    end
  end

  def destroy
    @like = Like.where(:post => params[:post_id], :user => current_user)
    
    if @like.any?
      @like.first.destroy
      render 'destroy', formats: [:json] 
    else
      redirect_to '/posts'
    end
  end
end
