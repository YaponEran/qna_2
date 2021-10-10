require 'rails_helper'

feature "Authenticates user can create", %q{
  In order to create answer to question
  As authenticated user
  I'd like to be able answer the question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  describe "Authenticated" do
    background do 
      sign_in(user)
      visit question_path(question)
    end

    scenario "user can create answer", js: true do
      fill_in "Body", with: "Some answer"
      click_on "Answer"
      
      within '.answers' do
        expect(page).to have_content "Some answer"
      end
    end

    scenario "Answers with attached file" do
      fill_in "Body", with: "Some answer"
      attach_file "File", ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
      click_on "Answer"

      within ".answers" do
        expect(page).to have_link 'rails_helper.rb'
        expect(page).to have_link 'spec_helper.rb'
      end
    end

    scenario "user with invalid attribute tries create answer", js: true do
      click_on "Answer"
      expect(page).to have_content "Body can't be blank"
    end
  end

  scenario "Un authenticated user tries create answer" do
    visit question_path(question)
    expect(page).to have_link "If you want answer the question u need to sign up"
  end

end