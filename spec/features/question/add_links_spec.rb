require 'rails_helper'

feature "User can add links to question", %q{
  In order to additional info to my question
  As an auestion author
  I'd like to be able add links
} do

  given(:author) { create(:user) }
  given(:gist_url) { "https://gist.github.com/YaponEran/e56750064307bdfb64cefc4f5092fecf" }

  scenario "User adds link when ask question" do
    sign_in(author)
    visit new_question_path

    fill_in "Title", with: "New title"
    fill_in "Body", with: "New body"

    fill_in "Links name", with: "My gist"
    fill_in "Url", with: gist_url

    click_on "Ask"

    expect(page).to have_link "My gist", href: gist_url
  end
end