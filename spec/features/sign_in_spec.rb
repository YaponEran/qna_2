require 'rails_helper'

feature "User can log in", %q{
  In order to ask questions
  as an authenticated user
  I'd like to be able sign in
} do

  given(:user) { User.create!(email: 'user@mail.com', password: '12345678') }
  background { visit new_user_session_path }

  scenario "Registired User tries to sign in" do
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"

    expect(page).to have_content "Signed in successfully."
  end

  scenario "Unregistired User tries to sign in" do
    fill_in "Email", with: "wrong@mail.com"
    fill_in "Password", with: "12345678"
    click_on "Log in"

    expect(page).to have_content "Invalid Email or password."
  end
end
