class AnswersController < ApplicationController

  before_action :set_answer, only: [:show, :edit, :update, :destroy]
  before_action :set_question, only: [:new, :create]

  def show; end

  def new
    @answer = @question.answers.new
    # @answer = Answer.new
  end

  def create
    @answer = @question.answers.new(answer_params)
    if @answer.save
      redirect_to @answer
    else
      render :new
    end
  end

  def edit; end

  def update
    if @answer.update(answer_params)
      redirect_to @answer
    else
      render :edit
    end
  end

  def destroy
   redirect_to questions_path if  @answer.destroy 
  end

  private
  def set_answer
    @answer = Answer.find(params[:id])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body, :question_id)
  end
end
