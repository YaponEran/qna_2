require 'rails_helper'

feature "User can Sign up", %q{
  In order to ask as question
  As un authenticated user
  I'd like to be able to sign up to system 
} do

  given(:user) { create(:user) }
  background { visit new_user_registration_path }

  scenario "User tries to sign up system with valid attributes" do
    fill_in "Email", with: "eran@test.com"
    fill_in "Password", with: "12345678"
    fill_in "Password confirmation", with: "12345678"
    click_on "Sign up"

    expect(page).to have_content "Welcome! You have signed up successfully."
  end

  scenario "User tries sign up with Invalid attributes" do
    click_on "Sign up"

    expect(page).to have_content "2 errors prohibited this user from being saved:"
  end

  scenario "User tries to sign up with existing email" do
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    fill_in "Password confirmation", with: user.password
    click_on "Sign up"

    expect(page).to have_content "Email has already been taken"
  end

end