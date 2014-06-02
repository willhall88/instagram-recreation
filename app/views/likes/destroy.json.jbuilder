json.post params[:post_id]
json.user current_user.username
json.like (link_to 'Like', like_path(params[:post_id]), method: :post, class:"like")
