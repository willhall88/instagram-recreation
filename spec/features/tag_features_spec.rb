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