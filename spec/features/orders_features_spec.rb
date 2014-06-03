require 'spec_helper'

describe 'orders' do
  
  context 'when not loggedin as admin' do
    
    it "should ask for the admin to sign in to view the page"do
      visit '/orders'
      expect(current_path).to eq '/admins/sign_in'
    end
  end

  context 'when logged in as an admin'do
    before do
      admin = Admin.create(username: 'willhall88', email: 'will@a.com', password: '12345678', password_confirmation: '12345678')
      @user = User.create(username: 'will', email: 'will@user.com', password: '12345678', password_confirmation: '12345678')
      @post = @user.posts.create()
      @comment = @post.comments.create(comment: "San Francisco", user: @user)
      login_as admin, scope: :admin
    end

    it"says no orders whent there are no orders" do
      visit ('/orders')
      expect(page).to have_content "No current orders"
    end

    it 'shows an order when an order has been made' do
      Order.create(user: @user, post: @post)
      visit ('/orders')
      expect(page).to have_content "will"
      expect(page).to have_content "San Francisco"
    end

  end

  context 'when logged in as a user' do
    before do
      @user = User.create(username: 'will', email: 'will@user.com', password: '12345678', password_confirmation: '12345678')
      @post = @user.posts.create()
      @comment = @post.comments.create(comment: "San Francisco", user: @user)
      login_as @user
      visit '/posts'
    end

    it 'shows a "buy" button with each post' do
      expect(page).to have_link 'Buy'
    end

    it 'takes you to the charge page when you click the buy button' do
      click_link 'Buy'
      expect(current_path).to eq (new_post_charge_path(@post))
    end


  end

  describe 'order emails' do
    before do
      clear_emails
    end

    it 'sends an email with the name of the picture' do
      @user = User.create(username: 'will', email: 'will@user.com', password: '12345678', password_confirmation: '12345678')
      @post = @user.posts.create()
      @comment = @post.comments.create(comment: "San Francisco", user: @user)
      Order.create(user:@user, post: @post)
      open_email('will@user.com')

      expect(current_email).to have_content 'Thanks for ordering a print of San Francisco'
    end

  end
end

