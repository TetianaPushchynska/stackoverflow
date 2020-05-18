class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_answer, only: :update

  respond_to :js

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params)
  end

  def update
    @answer.update(answer_params)
    respond_with @answer
  end

  private

  def load_answer
    @answer = Answer.find(params[:id])
    @question = @answer.question
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file, :id, :_destroy])
  end
end
