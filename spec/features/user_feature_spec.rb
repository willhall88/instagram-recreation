require 'spec_helper'

describe 'a users page ' do
  before do
    @user1 = User.create(username:"willhall88", email:"willhall88@hotmail.com", password:'12345678', password_confirmation:'12345678')
    login_as @user1
    @user1.posts.create(:caption => "this is 1 test")
    @user1.posts.create(:caption => "this is 2 test")
    @user1.posts.create(:caption => "this is 3 test")
    @user1.posts.create(:caption => "this is 4 test")
  end

  it "should show all the posts from one user" do
    visit profile_path(@user1)
    expect(page).to have_content "this is 1 test"
    expect(page).to have_content "this is 2 test"
    expect(page).to have_content "this is 3 test"
    expect(page).to have_content "this is 4 test"
  end


  
end