require 'spec_helper'


describe 'creating tags' do

  before do
    @user = User.create(username:"willhall88", email:"willhall88@hotmail.com", password:'12345678', password_confirmation:'12345678')
  end

  it "a comment can be created with one tag" do
    post = @user.posts.create()
    expect(Tag.all.count).to eq 0
    expect(Comment.all.count).to eq 0
    new_comment = post.comments.create(comment: 'this is a #hashtag test', user: @user)
    new_comment.create_hashtags
    expect(Comment.all.count).to eq 1
    expect(Tag.all.count).to eq 1
    expect(Tag.first.posts.first).to eq post
  end

  it "a comment can be created with two tags" do
    post = @user.posts.create()
    expect(Tag.all.count).to eq 0
    expect(Comment.all.count).to eq 0
    new_comment = post.comments.create(comment: 'this is a #double #hashtag test', user: @user)
    new_comment.create_hashtags
    expect(Comment.all.count).to eq 1
    expect(Tag.all.count).to eq 2
  end
end

