require 'rails_helper'

feature "User can edit answers", %q{
  In order to edit my answer
  As an author of answer
  I'd like to be able edit answer
} do

  given(:author) { create(:user) }
  given(:other_user) { create(:user) }

  given!(:question) { create(:question, user: author) }
  given!(:answer) { create(:answer, question: question, user: author) }

  scenario "Author can edit own answer", js: true do
    sign_in(author)

    visit question_path(question)
    expect(page).to have_link "Edit answer"
    click_on "Edit answer"
    within '.answers' do
      fill_in "Body", with: "Edited answer"
      click_on "Save"

      expect(page).to_not have_content answer.body
      expect(page).to have_content "Edited answer"
    end
  end

  scenario "Authenticated user tries to edit some one's answer"

  scenario "Un Authenticated user tried edit answer" do 
    visit question_path(question)
    expect(page).to_not have_content "Edit answer"
  end
end