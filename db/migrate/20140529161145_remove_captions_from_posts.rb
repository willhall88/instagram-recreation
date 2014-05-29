class RemoveCaptionsFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :caption
  end
end
