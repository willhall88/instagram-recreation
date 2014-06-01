json.user linkify_users(current_user.username)
json.post @post.id
json.unlike (link_to 'Unlike', unlike_path(@post.id), method: :post, class:"unlike")
