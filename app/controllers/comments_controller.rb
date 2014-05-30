class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
     unless params[:comment][:comment].blank?
      comment = @post.comments.new(params[:comment].permit(:comment))
      comment.user = current_user
      comment.save
      comment.create_hashtags
    end
    redirect_to '/posts'
  end
end
