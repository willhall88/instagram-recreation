require 'spec_helper'

describe 'commenting on a post' do
  before do
    user1 = User.create(username:"willhall88", email:"willhall88@hotmail.com", password:'12345678', password_confirmation:'12345678')
    @user2 = User.create(username:"user2", email:"willhall88@mail.com", password:'12345678', password_confirmation:'12345678')
    login_as user1
    post = user1.posts.create()
    post.comments.create(comment: 'this is a test', user: user1)
  end

  it "add a users comment to the post", js:true do
    visit '/posts'
    expect(page).to have_content 'this is a test'
    expect(page).to have_content 'willhall88'
    fill_in 'Comments...', with: 'this is a comment!'
    click_on('Add Comment')
    expect(current_path).to eq '/posts'
    expect(page).to have_content 'willhall88: this is a comment!'
  end

  it "can add more than one comment from the same user", js:true do
    visit '/posts'
    expect(page).to have_content 'this is a test'
    expect(page).to have_content 'willhall88'
    fill_in 'Comments...', with: 'this is a comment!'
    click_on('Add Comment')
    expect(page).to have_content 'willhall88: this is a comment!'
    fill_in 'Comments...', with: 'this is another comment!'
    click_on('Add Comment')
    expect(page).to have_content 'willhall88: this is a comment!'
    expect(page).to have_content 'willhall88: this is another comment!'
  end
end
