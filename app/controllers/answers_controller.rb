class AnswersController < ApplicationController

  before_action :authenticate_user!
  before_action :set_answer, only: [:show, :edit, :update, :destroy]
  before_action :set_question, only: [:create]
  # before_action :ensure_current_user_author_of_answer!, only: [:create, :update]

  def show; end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
    # if @answer.save
    #   redirect_to question_path(@question), notice: "Your answer successfully created"
    # end
  end

  def edit; end

  def update
    @answer.update(answer_params) if current_user.author_of?(@answer)
    @question = @answer.question
  end

  def destroy
    @answer.destroy if current_user.author_of?(@answer)
    # notice: "Your answer successfully deleted"
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

  def ensure_current_user_author_of_answer!
    return current_user.author_of?(@answer)
    redirect_to root_path, notice: "You are not author of #{@answer}"
  end

  def ensure_current_user_author_of_question!
    return current_user.author_of?(@answer.question)
    redirect_to root_path, notice: "You are not author of #{@answer.question}"
  end
end
