require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  let(:question) { create(:question, user: user) } #=> universal question
  let(:user) { create(:user) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 3) }
    before { get :index }

    it 'populater an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    before { get :show, params: {id: question} }
  
    it "assigns requested question to @question" do 
      expect(assigns(:question)).to eq(question)
    end

    it "renders show vies" do
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    before { login(user) }
    before { get :new }

    it "assigns question to a new to @question" do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it "assigns question to a new to @question" do
      expect(assigns(:question).links.first).to be_a_new(Link)
    end

    it "renderes new views" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    before { login(user) }
    
    context "with valid attributes" do
      it "saves a new question to the Database" do
        expect{ post :create, params: { question: attributes_for(:question)} }.to change(Question, :count).by(1)
      end

      it "create by current user" do
        post :create, params: { question: attributes_for(:question) }
        expect(assigns(:question).user_id).to eq subject.current_user.id
      end

      it "redirects to show view" do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to assigns(:question)
      end
    end

    context "with invalid attributes" do
      it 'does not save the question' do
        expect{ post :create, params: { question: attributes_for(:question, :invalid)} }.to_not change(Question, :count)
      end

      it 're-renders new view' do
        post :create, params: { question: attributes_for(:question, :invalid) }
        expect(response).to render_template :new
      end
    end
  end

  describe "PATCH #update" do
    before { login(user) }

    context "with valid attributes" do
      before { patch :update, params: { id: question, question: attributes_for(:question)}, format: :js }

      it "assigns requested question to @question" do
        expect(assigns(:question)).to eq question
      end

      it "changes question attributes" do
        patch :update, params: { id: question, question: { title: "new title", body: "new body"}, format: :js }
        question.reload
        
        expect(question.title).to eq "new title"
        expect(question.body).to eq "new body"
      end

      it "redirects to show view" do
        expect(response).to redirect_to question
      end
    end

    context "with invalid attributes" do
      before { patch :update, params: { id: question, question: attributes_for(:question, :invalid) }, format: :js }
      it 'does not change question attribute' do
        question.reload 

        expect(question.title).to eq 'MyString'
        expect(question.body).to eq 'MyBody'
      end

      it 're-render to edit' do
        expect(response).to render_template :update
      end
    end
  end

  describe "DELETE #destroy" do
    context "Author of question" do
      before { login(user) }
      let!(:question) { create(:question, user: user) }
      it "deletes question form Databse" do
        expect{ delete :destroy, params: { id: question } }.to change(Question, :count).by(-1)
      end

      it 'redirects to question' do
        delete :destroy, params: { id: question }
        expect(response).to redirect_to questions_path
     end
    end

    context "Non Author" do
      let(:other_user) { create(:user) }
      let!(:question) { create(:question)}
      before { login(other_user) }
      it "tries to delete question" do
        expect{ delete :destroy, params: { id: question} }.to_not change(Question, :count)
      end
    end

    context "Un authenticated user" do
      it "redirects to login page" do
        delete :destroy, params: { id: question }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

end
