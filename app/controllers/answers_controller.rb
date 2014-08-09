class AnswersController < ApplicationController
  before_action :set_vote, only: [:index, :create]

  def index
    @answers = @vote.answers
    @results = @answers.group(:answer).count
  end

  def create
    @answer = @vote.answers.build(answer_params)
    @answer.user_id = current_user.id
    if @answer.save   
      redirect_to vote_answers_path, notice: "Your vote was cast."
    else
      render 'new'
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find(params[:vote_id])
    end

    def answer_params
      params.require(:answer).permit(:answer)
    end
end
