require 'spec_helper'

describe 'a post' do 

  before do
    @user = User.create(username:"willhall88", email:"willhall88@hotmail.com", password:'12345678', password_confirmation:'12345678')
  end

  it 'should be created with a username' do
    post = Post.new()
    expect(post.save).to eq false
    post2 = @user.posts.new()
    expect(post2.save).to eq true
  end

end