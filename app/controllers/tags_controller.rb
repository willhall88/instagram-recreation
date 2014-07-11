class TagsController < ApplicationController

  def show
    @tag = Tag.find_by(tag: params[:id])
    @posts = @tag.posts
    @comment = Comment.new
  end
end
