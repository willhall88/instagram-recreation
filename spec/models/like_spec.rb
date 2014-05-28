require 'spec_helper'

describe "liking posts" do
  before do
    @user = User.create(username:"willhall88", email:"willhall88@hotmail.com", password:'12345678', password_confirmation:'12345678')
  end

  specify 'a user cannot like a post more than once' do
    post = @user.posts.create(:caption => "a new post")
    like = post.likes.new
    like.user = @user
    expect(like.save).to eq true
    like2 = post.likes.new
    like2.user = @user
    expect(like2.save).to eq false
  end

  specify 'a user can like two different posts' do
    post = @user.posts.create(:caption => "a new post")
    like = post.likes.new
    like.user = @user
    expect(like.save).to eq true
    post2 = @user.posts.new(:caption => "a second post")
    like2 = post2.likes.new
    like2.user = @user
    expect(like2.save).to eq true
  end

  specify 'a user can like two different posts, but not the same post twice' do
    post = @user.posts.create(:caption => "a new post")
    like = post.likes.new
    like.user = @user
    expect(like.save).to eq true
    post2 = @user.posts.new(:caption => "a second post")
    like2 = post2.likes.new
    like2.user = @user
    expect(like2.save).to eq true
    like2 = post2.likes.new
    like2.user = @user
    expect(like2.save).to eq false
  end
end

describe "unliking posts" do
  before do
    @user = User.create(username:"willhall88", email:"willhall88@hotmail.com", password:'12345678', password_confirmation:'12345678')
  end

  specify 'a user cannot like a post more than once' do
    post = @user.posts.create(:caption => "a new post")
    like = post.likes.new
    like.user = @user
    expect(like.save).to eq true
    unlike = Like.where(:post_id => post.id, :user_id => @user.id).first
    expect(Like.all.count).to eq 1 
    unlike.destroy
    expect(Like.all.count).to eq 0 
    unlike.destroy
    expect(Like.all.count).to eq 0 
  end
end


describe "likes get deleted when a post is deleted" do
  before do
    @user = User.create(username:"willhall88", email:"willhall88@hotmail.com", password:'12345678', password_confirmation:'12345678')
  end

  specify 'a like is deleted when a post is deleted' do
    post = @user.posts.create(:caption => "a new post")
    like = post.likes.new
    like.user = @user
    like.save
    expect(Post.all.count).to eq 1
    expect(Like.all.count).to eq 1
    post.destroy
    expect(Post.all.count).to eq 0
    expect(Like.all.count).to eq 0
  end
end