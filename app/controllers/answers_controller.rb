class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vote, only: [:index, :create]
  before_action :check_user_vote, only: :create     # prevent multiple votes
  before_action :check_requirements, only: :index   # to view results

  def index
    @answers = @vote.answers
    # TODO: use SQL to get 0 values as part of results hash
    # workaround is create hash of 0's and merge found answers
    h = {}    
    ary = @vote.get_choices
    ary.each{ |a| h[a] = 0 }
    @results = h.merge @answers.group(:answer).count
  end

  def create
    @answer = @vote.answers.build(answer_params)
    @answer.user_id = current_user.id
    if @answer.save
      flash[:success] = 'Thanks, your vote was cast.'
      redirect_to root_path
    else
      flash[:notice] = "Please select an answer."
      redirect_to @vote
    end
  end

  private

    def set_vote
      @vote = Vote.find(params[:vote_id])
    end

    def answer_params
      params.require(:answer).permit(:answer, :comment)
    end

    def check_user_vote
      if voted?(@vote.answers)
        flash[:notice] = "Sorry, you've already voted."
        redirect_to root_path
      end
    end

    def voted?(answers)
      answers.find_by(user: current_user)
    end

    def check_requirements
      unless voted?(@vote.answers) && @vote.finished?
        flash[:notice] = "Sorry, you cannot see results yet."
        redirect_to root_path
      end
    end
 
end
