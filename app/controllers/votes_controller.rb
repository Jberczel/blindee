class VotesController < ApplicationController
  before_action :set_vote, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user! 
  before_filter :answered, only: :show
  before_filter :check_creator, only: [ :edit, :update, :destroy ]


  # GET /votes
  def index
    @votes = Vote.all
  end

  # GET /votes/1
  def show
    @answer = @vote.answers.build
  end

  # GET /votes/new
  def new
    @vote = current_user.created_votes.build
  end

  # GET /votes/1/edit
  def edit
    @invite = @vote.invites.build
  end

  # POST /votes
  def create
    @vote = current_user.created_votes.build(vote_params)

    if @vote.save
      redirect_to @vote, notice: 'Vote was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /votes/1
  def update
    if @vote.update(vote_params)
      redirect_to @vote, notice: 'Vote was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /votes/1
  def destroy
    @vote.destroy
    redirect_to votes_url, notice: 'Vote was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def vote_params
      params.require(:vote).permit(:question, :choices)
    end

    def answered
      voted = current_user.answers.find_by(:vote_id => params[:id])
      redirect_to root_path, notice: "Already cast vote" if voted
    end

    def check_creator
      redirect_to root_path unless current_user = @vote.creator
    end

    
end
