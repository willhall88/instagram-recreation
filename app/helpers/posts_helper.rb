module PostsHelper

  def linkify_tags(comment)
    comment.gsub(/#(\S+)/, "<a href='/tags/\\1'>\\0</a>").html_safe
  end
end
