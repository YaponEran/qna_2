require 'rails_helper'

feature "User can sign out", %q{
  In order to finish my session
  As registired user
  I'd like to finish my session
} do

  describe "Auhenticated user" do
    given(:user) { create(:user) }
    background { sign_in(user) }

    scenario "can sign out" do
      visit questions_path
      click_on "Sign out"

      expect(page).to have_content "Signed out successfully."
    end
  end

  scenario "Unauhthenticated user tries sign out" do
    visit questions_path
    expect(page).to_not have_content "Sign out"
  end
end