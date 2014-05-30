require 'spec_helper'

describe 'adding tags to the posts' do

  before do
    user = User.create(username:"willhall88", email:"willhall88@hotmail.com", password:'12345678', password_confirmation:'12345678')
    login_as user
  end


  it 'should show tags in the caption as links' do
    visit '/posts/new'
    fill_in 'Comment', with: 'my first post! and this is my #hashtag'
    click_on('Create Post')
    expect(page).to have_content 'my first post! and this is my #hashtag'
    expect(page).to have_link '#hashtag'
  end
end

describe 'filtering by tags' do
  
  before do
    user = User.create(username:"willhall88", email:"willhall88@hotmail.com", password:'12345678', password_confirmation:'12345678')
    post = user.posts.create()
    post.comments.create(comment: '#name', user: user)
    post2 = user.posts.create()
    post2.comments.create(comment: '#no_tag', user: user)
    post3 = user.posts.create()
    post3.comments.create(comment: '#name', user: user)
    post.comments.first.create_hashtags
    post2.comments.first.create_hashtags
    post3.comments.first.create_hashtags
    login_as user
  end
  
  it 'should should only show the posts linked with a tag when it is clicked on' do
    visit '/posts'
    first(:link, '#name').click
    expect(current_path).to eq '/tags/name'
  end
end