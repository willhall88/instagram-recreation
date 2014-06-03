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
      login_as admin, scope: :admin
    end

    it"says no orders whent there are no orders" do
      visit ('/orders')
      expect(page).to have_content "No current orders"
    end

    # it 'shows an order when an order has been made' do


    # end

  end
end