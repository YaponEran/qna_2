require "rails_helper"

feature "adding question award", %q{
  In order to add awward
  As authenticated user
  I'w like to be able add award
} do
  given(:user) { create(:user) }

  scenario "User adds award while adding question" do
    sign_in(user)
    visit new_question_path

    fill_in "Title", with: "Test question"
    fill_in "Body", with: "question text"
    fill_in "Award title", with: "some title"
    attach_file "Image", "#{Rails.root}/spec/support/assets/image1.png"

    expect(page).to have_content 'some title'
  end
end