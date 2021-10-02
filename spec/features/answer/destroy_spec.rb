require 'rails_helper'

feature "Author can delete answer", %q{
  In order to delete answer
  As Author of answer
  I'w like to be able delete answer
} do

  given(:author) { create(:user) }
  given(:other) { create(:user) }

  given!(:question) { create(:question, user: other) }
  given!(:answer) { create(:answer, question: question, user: author) }

  describe "Author" do
    scenario "can delete answer", js: true do
      sign_in(answer.user)
      visit question_path(answer.question) 

      expect(page).to have_link "Delete answer"

      click_on "Delete answer"
      page.driver.browser.switch_to.alert.accept
      expect(page).to_not have_content answer
    end

    scenario "tries delete some's answer", js: true do
      sign_in(other)
      visit question_path(answer.question) 

      expect(page).to_not have_link "Delete answer"
    end
  end
  
  scenario "Guest tries to delete answer", js: true do
    visit question_path(answer.question)
    expect(page).to_not have_link "Delete answer"
  end

end