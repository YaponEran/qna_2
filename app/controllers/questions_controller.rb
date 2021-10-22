class QuestionsController < ApplicationController
  include Voted
  
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  after_action :publish_question, only: :create

  def index
    @questions = Question.all
  end

  def show
    @answer = @question.answers.new
    @answer.links.new
    gon.question_id = @question.id
    gon.question_author_id = @question.user_id
  end

  def new
    @question = Question.new
    @question.links.new
    @question.build_award
  end

  def edit;end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      redirect_to @question, notice: "Your question successfully created"
    else
      render :new
    end
  end

  def update
    @question.update(question_params)
    # if @question.update(question_params)
    #   redirect_to @question
    # else
    #   render :edit
    # end
  end

  def destroy
    # redirect_to questions_path if @question.destroy
    @question.destroy if current_user.author_of?(@question)
    redirect_to questions_path, notice: "Your questin was succeessfylly deleted!"
  end

  private
  def set_question
    @question = Question.with_attached_files.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, files: [], links_attributes: [:name, :url], award_attributes: [:title, :image, :_destroy])
  end

  def publish_question
    return if @question.errors.any?

    ActionCable.server.broadcast(
      'questions',
      ApplicationController.render(
        partial: 'questions/question',
        locals: { question: @question }
      )
    )
  end
end
