class AnswersController < ApplicationController
  include Voted
  
  before_action :authenticate_user!
  before_action :set_answer, only: [:show, :edit, :update, :destroy, :choose_best]
  before_action :set_question, only: [:create]

  after_action :publish_answer, only: [:create]

  def show; end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
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

  def choose_best
    @answer.update_to_best!
    @question = @answer.question
  end

  private
  def set_answer
    @answer = Answer.with_attached_files.find(params[:id])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body, :question_id, files: [], links_attributes: [:name, :url])
  end

  def ensure_current_user_author_of_answer!
    return current_user.author_of?(@answer)
    redirect_to root_path, notice: "You are not author of #{@answer}"
  end

  def ensure_current_user_author_of_question!
    return current_user.author_of?(@answer.question)
    redirect_to root_path, notice: "You are not author of #{@answer.question}"
  end

  def publish_answer
    return if @answer.errors.any?

    ActionCable.server.broadcast(
      "question_#{@question.id}_answers",
      {
        answer: @answer,
        links: @answer.links
      }
    )
  end
end
