require 'rails_helper'

feature "Authenticated User can delete", %q{
  In Order to delete question
  As Author of question
  I'd like to delete question
} do

  given(:author) { create(:user) }
  given(:other_user) { create(:user) }
  given(:question) { create(:question, user: author) }

  scenario "Author can delete question" do
    sign_in(author)
    visit question_path(question)
    
    expect(page).to have_content question.title
    click_on "Delete"
    expect(page).to_not have_content question.title
    expect(page).to_not have_content question.body
    expect(page).to have_content "Your questin was succeessfylly deleted!"
  end

  scenario "Authenticates user tries delete some ones question" do
    sign_in(other_user)
    visit question_path(question)
    expect(page).to_not have_content "Delete"
  end

  scenario "Un authenticates user tries to delete question" do
    visit question_path(question)
    expect(page).to_not have_content "Delete"
  end

end