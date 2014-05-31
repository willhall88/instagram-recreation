module PostsHelper

  def linkify_tags(comment)
    comment.gsub(/#(\S+)/, "<a href='/tags/\\1'>\\0</a>").html_safe
  end

    def linkify_users(username)
    username.gsub(/.+/, "<a href='/profiles/\\0'>\\0</a>").html_safe
  end
end
