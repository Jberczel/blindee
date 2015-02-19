class VotesController < ApplicationController
  include VotesHelper
  before_action :authenticate_user!
  before_action :set_vote, only: [ :show, :destroy, :new_notification, :send_notification ]
  before_action :already_notified?, only: [ :new_notification, :send_notification ]

  def index
    @votes = Vote.where(public_vote: true).includes(:creator)
    @votes_presenter = VotePresenter.wrap(@votes, view_context)
  end

  def show
    if !@vote_presenter.current_user_invited? && !@vote_presenter.public_vote?
      redirect_to root_path, notice: "Sorry, you weren't invited to this Vote."
    end
  end

  def new
    @vote = current_user.created_votes.build
  end

  def create
    @vote = current_user.created_votes.build(vote_params)
    if @vote.save
      if @vote.public_vote
        redirect_to @vote, :flash => { :success => 'Your public vote was successfully created.' }
      else
        redirect_to invite_vote_path(@vote),  :flash => { :success => 'Vote was successfully created. Now invite some voters!' }
      end
    else
      flash.now[:error] = 'Uh oh, something went wrong.'
      render :new
    end
  end

  def destroy
    if @vote_presenter.creator_is_current_user?
      @vote.destroy
      redirect_to root_path, notice: 'Vote was successfully destroyed.'
    end
  end

  def new_notification
  end

  def send_notification
    Mailer.send_notification(@vote, vote_url(@vote), params[:comment]).deliver
    @vote.update_attributes(:notified => true)
    redirect_to vote_path(@vote), :notice => 'Notifications sent'
  end

  private

  def set_vote
    @vote           = Vote.find(params[:id])
    @vote_presenter = VotePresenter.new(@vote, view_context)
  end

  def vote_params
    params.require(:vote).permit(:question, :choices, :details, :public_vote)
  end

  def already_notified?
    if @vote_presenter.notified? || @vote_presenter.public_vote?
      redirect_to vote_path(@vote), notice: "Already notified."
    end
  end
end
