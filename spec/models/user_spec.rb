require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  it { should have_many(:questions).dependent(:destroy) }
  it { should have_many(:answers).dependent(:destroy) }
  
  it { should have_many(:awards).dependent(:destroy) }

  describe "#author_of?" do
    let(:user) { create(:user) }
    let(:question_author) { create(:question, user: user) }
    let(:question) { create(:question) }

    it "current user is author of question" do
      expect(user).to be_author_of(question_author)
    end

    it "user is not author of question" do
      expect(user).to_not be_author_of(question)
    end
  end
end
