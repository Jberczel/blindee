class VotesController < ApplicationController
  include VotesHelper
  before_action :authenticate_user!
  before_action :set_vote, only: [ :show, :edit, :update, :destroy ]
  before_action :check_invited, only: :show, unless: :public_vote?
  before_action :check_creator, only: [ :edit, :update, :destroy ]


  # GET /votes
  def index
    @votes = Vote.where(public_vote: true)
  end

  # GET /votes/1
  def show
    @answer = @vote.answers.build
    @invites = @vote.invites
  end

  # GET /votes/new
  def new
    @vote = current_user.created_votes.build
  end

  # GET /votes/1/edit
  def edit

  end

  # POST /votes
  def create
    @vote = current_user.created_votes.build(vote_params)
   
    if @vote.save
      # flash doesn't appear if I use short-hand style
      flash[:success] = 'Vote was successfully created. Now invite some voters!'
      redirect_to invite_vote_path(@vote)
    else
      flash[:error] = "Uh oh."
      render :new
    end
  end

  # PATCH/PUT /votes/1
  def update
    if @vote.update(vote_params)
      # flash doesn't appear if I use short-hand style
      flash[:success] = 'Vote was successfully updated.'
      redirect_to @vote
    else
      render :edit
    end
  end

  # DELETE /votes/1
  def destroy
    @vote.destroy
    redirect_to root_path, notice: 'Vote was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def vote_params
      params.require(:vote).permit(:question, :choices, :details, :public_vote)
    end

    def public_vote?
      @vote.public?
    end
end
