require 'spec_helper'

describe 'posts' do
  context "when user is logged out" do
    it "should ask for user to register or sign in" do
      visit '/posts'
      expect(page).not_to have_content "Create Post"
      expect(page).to have_content "You need to sign in or sign up before continuing"
    end 
  end

  context "when user is logged in " do
    before do
      user = User.create(username:"willhall88", email:"willhall88@hotmail.com", password:'12345678', password_confirmation:'12345678')
      login_as user
    end

    it 'should have no posts to begin with' do
      visit '/posts'
      expect(page).to have_content "no current posts yet"
    end

    it 'should be able to add a new post' do
      visit '/posts'
      click_on('New Post')

      expect(current_path).to eq '/posts/new'
      fill_in 'Caption', with: 'my first post!'
      click_on('Create Post')
      expect(current_path).to eq '/posts'
      expect(page).to have_content 'my first post!'
      expect(page).to have_content 'willhall88'
    end
  end
end