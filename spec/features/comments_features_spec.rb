require 'spec_helper'

describe 'commenting on a post' do
  before do
    user1 = User.create(username:"willhall88", email:"willhall88@hotmail.com", password:'12345678', password_confirmation:'12345678')
    @user2 = User.create(username:"user2", email:"willhall88@mail.com", password:'12345678', password_confirmation:'12345678')
    login_as user1
    post = user1.posts.create()
    post.comments.create(comment: 'this is a test', user: user1)
  end

  it "add a users comment to the post" do
    visit '/posts'
    expect(page).to have_content 'this is a test'
    expect(page).to have_content 'willhall88'
    fill_in 'Comments...', with: 'this is a comment!'
    click_on('Add Comment')
    expect(current_path).to eq '/posts'
    expect(page).to have_content 'willhall88: this is a comment!'
  end

  it "cannot be created as an empty comment" do
    logout
    login_as @user2
    visit '/posts'
    fill_in 'Comments...', with: ''
    click_on('Add Comment')
    visit '/posts'
    expect(page).to have_content 'this is a test'
    expect(page).to have_content 'willhall88'
    expect(page).not_to have_content 'user2:'
  end

#   it "can add more than one comment from the same user" do
#     visit '/posts'
#     expect(page).to have_content 'this is a test'
#     expect(page).to have_content 'willhall88'
#     fill_in 'Comment', with: 'this is a comment!'
#     click_on('Add Comment')
#     expect(page).to have_content 'willhall88: this is a comment!'
#     fill_in 'Comment', with: 'this is another comment!'
#     click_on('Add Comment')
#     expect(page).to have_content 'willhall88: this is a comment!'
#     expect(page).to have_content 'willhall88: this is another comment!'
#   end
# end

# describe 'unliking a post' do
#   before do
#     user1 = User.create(username:"willhall88", email:"willhall88@hotmail.com", password:'12345678', password_confirmation:'12345678')
#     @user2 = User.create(username:"user2", email:"willhall88@mail.com", password:'12345678', password_confirmation:'12345678')
#     login_as user1
#     user1.posts.create(:caption => "this is a test")
#   end

#   it "removes a users like from the post" do
#     visit '/posts'
#     expect(page).to have_content 'this is a test'
#     expect(page).to have_content 'willhall88'
#     click_on('Like')
#     expect(page).to have_content 'Liked by willhall88.'
#     click_on('Unlike')
#     expect(page).not_to have_content 'Liked by willhall88.'
#   end

#   it "removes the users like from the post and other users can no longer see the like" do
#     visit '/posts'
#     click_on('Like')
#     click_on('Unlike')
#     logout
#     login_as @user2
#     visit '/posts'
#     expect(page).to have_content 'this is a test'
#     expect(page).to have_content 'willhall88'
#     expect(page).not_to have_content 'Liked by willhall88.'
#   end
end