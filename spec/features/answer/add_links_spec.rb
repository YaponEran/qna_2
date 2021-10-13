require "rails_helper"

feature "User can add links to answer", %q{
  In order to additional info to my question
  As an author of answer
  I'd like to be able add links
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given(:gist_url) { "https://gist.github.com/YaponEran/e56750064307bdfb64cefc4f5092fecf" }

  scenario "User add links when anwers", js: true do
    sign_in(user)
    visit question_path(question)

    fill_in "Body", with: "new answer"
    fill_in "Links name", with: "My gist"
    fill_in "Url", with: gist_url

    click_on "Answer"

    within ".answers" do
      expect(page).to have_link "My gist", href: gist_url
    end
  end
end