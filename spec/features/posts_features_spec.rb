require 'spec_helper'

describe 'posts' do
  
  it 'should have no posts to begin with' do
    visit '/posts'
    expect(page).to have_content "no current posts yet"
  end
end