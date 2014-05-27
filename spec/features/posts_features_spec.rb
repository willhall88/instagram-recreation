require 'spec_helper'

describe 'posts' do
  
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
  end
end