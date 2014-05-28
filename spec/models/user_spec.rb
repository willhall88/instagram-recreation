require 'spec_helper'

describe "posts and likes get deleted when a user is deleted" do
  before do
    @user = User.create(username:"willhall88", email:"willhall88@hotmail.com", password:'12345678', password_confirmation:'12345678')
  end

  specify 'a post and like is deleted when a user is deleted' do
    post = @user.posts.create(:caption => "a new post")
    like = post.likes.new
    like.user = @user
    like.save
    expect(User.all.count).to eq 1
    expect(Post.all.count).to eq 1
    expect(Like.all.count).to eq 1
    @user.destroy
    expect(User.all.count).to eq 0
    expect(Post.all.count).to eq 0
    expect(Like.all.count).to eq 0
  end

  specify ' a like is deleted from a post owned by a different user, when the first user is deleted' do
    user2 = User.create(username:"willhall", email:"willhall@hotmail.com", password:'12345678', password_confirmation:'12345678')
    post = user2.posts.create(:caption => "a new post")
    like = post.likes.new
    like.user = @user
    like.save
    expect(User.all.count).to eq 2
    expect(Post.all.count).to eq 1
    expect(Like.all.count).to eq 1
    @user.destroy
    expect(User.all.count).to eq 1
    expect(Post.all.count).to eq 1
    expect(Like.all.count).to eq 0
  end
end