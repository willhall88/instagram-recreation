class TagsController < ApplicationController

  def show
    puts "id"
    puts params[:id]
    @tag = Tag.find_by(tag: params[:id])
    puts 'tag'
    puts Tag.first
    @posts = @tag.posts
    @comment = Comment.new
  end
end
