require 'rails_helper'

feature "User can log in", %q{
  In order to ask questions
  as an authenticated user
  I'd like to be able sign in
} do

  describe "Registired user" do
    given(:user) { create(:user) }
    background { sign_in(user) }

    scenario "tries to sign in" do
    expect(page).to have_content "Signed in successfully."
    end
  end

  scenario "Unregistired User tries to sign in" do
    visit new_user_session_path
    fill_in "Email", with: "wrong@mail.com"
    fill_in "Password", with: "12345678"
    click_on "Log in"

    expect(page).to have_content "Invalid Email or password."
  end
end
