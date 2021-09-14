require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:answer) { create(:answer) }
  let(:question) { create(:question) }

  describe "GET #show" do
    before { get :show, params: { id: answer } }

    it 'assigns questions answer to answer' do
      expect(assigns(:answer)).to eq answer
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    before { get :new, params: { question_id: question } }

    it "assigns answer to a new @answer" do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "With valid attributes" do
      it "saves new answer to database" do
        expect{ post :create, params: { answer: attributes_for(:answer), question_id: question } }.to change(Answer, :count).by(1)
      end

      it "redirects to question answer" do
        post :create, params: { answer: attributes_for(:answer), question_id: question }
        expect(response).to redirect_to assigns(:answer)
      end
    end

    context "With invalid attributes" do
      it "does not save answer to database" do 
        expect{ post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question} }.to_not change(Answer, :count)
      end

      it 're-render new view' do
        post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question }
        expect(response).to render_template :new
      end
    end
  end

  describe "GET #edit" do
    before { get :edit, params: { id: answer } }

    it "assigns answer to a @answer" do
      expect(assigns(:answer)).to eq answer
    end

    it "renders edit view" do 
      expect(response).to render_template :edit
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do 
      it "assigns answer to a @answer" do
        patch :update, params: { id: answer, answer: attributes_for(:answer), question_id: question}
        expect(assigns(:answer)).to eq answer 
      end

      it "changes answer attributes" do
        patch :update, params: { id: answer, answer: { body: "Update answer", question_id: question} }
        answer.reload

        expect(answer.body).to eq "Update answer"
      end

      it "redirects to answer" do
        patch :update, params: { id: answer, answer: { body: "Update answer", question_id: question} }
        expect(response).to redirect_to answer
      end
    end

    context "with invalid attributes" do
      before { patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid), question_id: question } }
      it "does not save answer to database" do
        answer.reload

        expect(answer.body).to eq "MyAnswer"
      end

      it 're-renders edit-view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:answer) { create(:answer) }
    it "Deletes answer from database" do
      expect{delete :destroy, params: { id: answer }}.to change(Answer, :count).by(-1)
    end

    it "redirects to questions path" do
      delete :destroy, params: { id: answer }

      expect(response).to redirect_to questions_path
    end
  end

end
