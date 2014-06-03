require 'spec_helper'

describe 'admin' do

  it 'cannot sign up' do
    # visit '/admins/sign_in'
    # expect(page).not_to have_content ('sign up')
    expect { visit '/admins/sign_up' }.to raise_error
  end
  
end