class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    comment = @post.comments.new(params[:comment].permit(:comment))
    comment.user = current_user
    comment.save
    redirect_to '/posts'
  end
end
