require 'rails_helper'

RSpec.describe Ability do
  subject(:ability) { Ability.new(user) }

  describe "for guest" do
    let(:user) { nil }

    it { should be_able_to :read, Question }
    it { should be_able_to :read, Answer }
    it { should be_able_to :read, Comment }

    it { should_not be_able_to :manage, :all }
  end

  describe "for admin" do
    let(:user) { create(:user, admin: true) }

    it { should be_able_to :manage, :all }
  end

  describe "for user" do
    let(:user) { create(:user) }
    let(:other) { create(:user) }

    it { should_not be_able_to :manage, :all }

    it { should be_able_to :read, :all }

    it { should be_able_to :create, Question }
    it { should be_able_to :create, Answer }
    it { should be_able_to :create, Comment }

    it { should be_able_to :update, create(:question, user: user), user: user }
    it { should_not be_able_to :update, create(:question, user: other), user: user }

    it { should be_able_to :update, create(:answer, user: user), user: user }
    it { should_not be_able_to :update, create(:answer, user: other), user: user }

    context "to destroy" do
      it { should be_able_to :destroy, create(:question, user: user), user: user}
      it { should be_able_to :destroy, create(:answer, user: user), user: user}
    end

    context 'to choose best answer' do
      context 'as author of the question' do
        it { should be_able_to :choose_best, create(:answer, user: user), user: user }
      end
    end
  end
end