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
      fill_in 'Comment', with: 'my first post!'
      click_on('Create Post')
      expect(current_path).to eq '/posts'
      expect(page).to have_content 'my first post!'
    end

    it 'should show the username with a new post' do
      visit '/posts'
      click_on('New Post')

      expect(current_path).to eq '/posts/new'
      fill_in 'Comment', with: 'my first post!'
      click_on('Create Post')
      expect(current_path).to eq '/posts'
      expect(page).to have_content 'my first post!'
      expect(page).to have_content 'willhall88'
    end

    context "adding photos to a post" do
      it 'has a photo with a post' do
        visit '/posts/new'
        fill_in 'Comment', with: 'my first post!'
        attach_file 'Picture', Rails.root.join("./spec/images/mammoth.jpg")
        click_on('Create Post')
        expect(current_path).to eq '/posts'
        expect(page).to have_content 'my first post!'
        expect(page).to have_content 'willhall88'
        expect(page).to have_css 'img.uploaded-pic'
      end
    end
  end
end

describe 'deleting a post' do
  before do
    user1 = User.create(username:"willhall88", email:"willhall88@hotmail.com", password:'12345678', password_confirmation:'12345678')
    @user2 = User.create(username:"user2", email:"willhall88@mail.com", password:'12345678', password_confirmation:'12345678')
    login_as user1
    post = user1.posts.create()
    post.comments.create(comment: 'this is a test', user: user1)
  end

  it "can be deleted by the creator of the post" do
    visit '/posts'
    expect(page).to have_content 'this is a test'
    expect(page).to have_content 'willhall88'
    click_on('Delete Post')
    expect(page).not_to have_content 'this is a test'
    expect(page).not_to have_content 'willhall88'
  end

  it "cannot be deleted by anybody else" do
    logout
    login_as @user2
    visit '/posts'
    expect(page).to have_content 'this is a test'
    expect(page).to have_content 'willhall88'
    click_on('Delete Post')
    expect(page).to have_content 'this is a test'
    expect(page).to have_content 'willhall88'
  end

end

describe 'liking a post' do
  before do
    user1 = User.create(username:"willhall88", email:"willhall88@hotmail.com", password:'12345678', password_confirmation:'12345678')
    @user2 = User.create(username:"user2", email:"willhall88@mail.com", password:'12345678', password_confirmation:'12345678')
    login_as user1
    post = user1.posts.create()
    post.comments.create(comment: 'this is a test', user: user1)
  end

  it "add a users like to the post" do
    visit '/posts'
    expect(page).to have_content 'this is a test'
    expect(page).to have_content 'willhall88'

    click_on('Like')
    expect(page).to have_content 'willhall88 likes this'
  end

  it "add a users like to the post and other users can see the like" do
    visit '/posts'
    click_on('Like')
    logout
    login_as @user2
    visit '/posts'
    expect(page).to have_content 'this is a test'
    expect(page).to have_content 'willhall88'
    expect(page).to have_content 'willhall88 likes this'
  end

  it "cannot add more than one like from the same user" do
    visit '/posts'
    expect(page).to have_content 'this is a test'
    expect(page).to have_content 'willhall88'

    click_on('Like')
    expect(page).to have_content 'willhall88 likes this'
    click_on('Like')
    expect(page).to have_content 'willhall88 likes this'
    expect(page).not_to have_content 'willhall88, willhall88 likes this'
  end
end

describe 'unliking a post' do
  before do
    user1 = User.create(username:"willhall88", email:"willhall88@hotmail.com", password:'12345678', password_confirmation:'12345678')
    @user2 = User.create(username:"user2", email:"willhall88@mail.com", password:'12345678', password_confirmation:'12345678')
    login_as user1
    post = user1.posts.create()
    post.comments.create(comment: 'this is a test', user: user1)
  end

  it "removes a users like from the post" do
    visit '/posts'
    expect(page).to have_content 'this is a test'
    expect(page).to have_content 'willhall88'
    click_on('Like')
    expect(page).to have_content 'willhall88 likes this'
    click_on('Unlike')
    expect(page).not_to have_content 'willhall88 likes this'
  end

  it "removes the users like from the post and other users can no longer see the like" do
    visit '/posts'
    click_on('Like')
    click_on('Unlike')
    logout
    login_as @user2
    visit '/posts'
    expect(page).to have_content 'this is a test'
    expect(page).to have_content 'willhall88'
    expect(page).not_to have_content 'willhall88 likes this'
  end
end