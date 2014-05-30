class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  
  def create_hashtags
    comment.split.each do |word|
      if word.chars.first == '#'
        tag = Tag.find_or_create_by(tag: word.delete('#'))
        post.tags << tag
      end
    end
  end
end
