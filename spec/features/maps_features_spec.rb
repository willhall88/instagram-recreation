require 'spec_helper'

describe 'Maps' do
  context "map button" do 
    before do
      @user1 = User.create(username:"willhall88", email:"willhall88@hotmail.com", password:'12345678', password_confirmation:'12345678')
      login_as @user1
    end
    
    it 'has a map button with a post that has a location' do
      post = @user1.posts.create(latitude: 51.5231, longitude: -0.08716)
      visit '/posts'
      expect(page).to have_link 'Map'
    end


    it 'has no map button with a post that has a location' do
      post = @user1.posts.create()
      visit '/posts'
      expect(page).not_to have_link 'Map'
    end

    it 'the map button links to the show map page' do
      post = @user1.posts.create(latitude: 51.5231, longitude: -0.08716)
      visit '/posts'
      click_link('Map')
      expect(current_path).to eq post_map_path(post)
      expect(page).to have_content "Location of picture"
    end
  end

end