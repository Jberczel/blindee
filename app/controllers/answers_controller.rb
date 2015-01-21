class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vote, only: [:index, :create]
  before_action :set_vote_presenter, only: [:index, :create]

  def index
    if @vote_presenter.finished? && @vote_presenter.current_user_voted?
      @results = GenerateChartData.results(@vote)
    else
      redirect_to root_path, :notice => 'Sorry, you cannot view results yet.'
    end
  end

  def create
    @answer = @vote.answers.build(answer_params.merge(user: current_user))
    if @vote_presenter.current_user_voted?
      redirect_to root_path, :notice => "Sorry you've already voted"
    elsif @answer.save
      redirect_to root_path, :flash => { :success => 'Thanks, your vote was cast.' }
    else
      redirect_to @vote, :notice => 'Please select an answer.'
    end
  end

  private

  def set_vote
    @vote = Vote.find(params[:vote_id])
  end

  def set_vote_presenter
    @vote_presenter = VotePresenter.new(@vote, view_context)
  end

  def answer_params
    params.require(:answer).permit(:answer, :comment)
  end
end
