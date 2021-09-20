require 'rails_helper'

feature 'User can see all question', %q{
  In order to find Answer
  As any user
  I'd like to see all questions
} do
  
  given(:user) { create(:user) }
  given!(:questions) { create_list(:question, 3, user: user)}

  scenario "User can see all questions" do
    visit questions_path
    questions.each do |question|
      expect(page).to have_content question.title
      expect(page).to have_content question.body
    end
  end
end