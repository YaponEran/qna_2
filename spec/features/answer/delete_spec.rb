require 'rails_helper'

feature "Author of answer can delete answer", %q{
  In order to delete answer
  As author of answer
  I'd like to delete answer
} do

  given(:author) { create(:user) }
  given(:user) { create(:user) }

  given!(:answer) { create(:answer, question: question, user: author)}
  given!(:question) { create(:question, user: author) }

  scenario "Author can delete answer" do
    sign_in(author)
    visit question_path(question)
    expect(page).to have_content answer.body

    click_on "Delete answer"
    expect(page).to_not have_content answer.body
    expect(page).to have_content "Your answer successfully deleted"
  end

  scenario "Un author tries delete answer" do
    visit question_path(question)
    expect(page).to_not have_content "Delete answer"
  end
end
