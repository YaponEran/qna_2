require 'rails_helper'

feature "User can edit question", %q{
  In order to edit my question
  As an author of question
  I'd like to be able edir answer
} do

  given(:author) { create(:user) }
  given(:other_user) { create(:user) }
  given!(:question) { create(:question, user: author) }

  describe "Author user", js: true do
    scenario "can edit question" do
      sign_in(author)
      visit question_path(question)
      expect(page).to have_link "Edit question"
      click_on "Edit question"
  
      within '.questions' do
        fill_in "Title", with: "Edited question title"
        fill_in "Body", with: "Edited question body"
        click_on "Save question"
  
        expect(page).to have_content "Edited question title"
        expect(page).to have_content "Edited question body"
      end
    end

    scenario "can edit question with attached file" do
      sign_in(author)
      visit question_path(question)
      click_on "Edit question"

      within ".questions" do
        fill_in "Title", with: "Edited question title"
        fill_in "Body", with: "Edited question body"
        attach_file "File", ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
        click_on "Save question"

        expect(page).to have_content "Edited question title"
        expect(page).to have_content "Edited question body"
        expect(page).to have_link 'rails_helper.rb'
        expect(page).to have_link 'spec_helper.rb'
      end
    end

    scenario "tries edit some's question" do 
      sign_in(other_user)
      visit question_path(question)
      expect(page).to_not have_link "Edit question"
    end
  end

  scenario "Guest tried edit answer", js: true do
    visit question_path(question)
    expect(page).to_not have_link "Edit question"
  end
  
end