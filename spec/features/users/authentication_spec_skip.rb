require 'rails_helper'

feature 'Authentication', js: true do
  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  feature 'login' do
    scenario 'with valid inputs' do 
      visit '#/sign_in'
      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
      find("button", text: "Sign in").click
      expect(page).to have_content('Sign out')
    end
  end
end