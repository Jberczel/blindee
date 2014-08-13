class VotesController < ApplicationController
  before_action :set_vote, only: [:show, :edit, :update, :destroy, :invite]
  before_action :check_answered, only: :show
  before_action :check_invited, only: :show
  before_action :check_creator, only: [ :edit, :update, :destroy, :invite ]


  # GET /votes
  def index
    @votes = Vote.all
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
    @invite = @vote.invites.build
  end

  # POST /votes
  def create
    @vote = current_user.created_votes.build(vote_params)
   
    if @vote.save
      # flash doesn't appear if I use short-hand style
      flash[:success] = 'Vote was successfully created.'
      redirect_to @vote
    else
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
    redirect_to votes_url, notice: 'Vote was successfully destroyed.'
  end

  # invite multiple voters
  def invite
    email_regex = /\A[\w+\-.]+@[a-z\d\-.]+[^.]\.[a-z]+\z/i
    emails = params[:invite_emails].split(',')
    emails.each do |email|
      #validate email before creating invite (strip white spaces and newlines)
      # !strip returns nill if no change
      email = email.strip
      if email.strip =~ email_regex
        # recipient id set in callback if user already registered
        @invite = Invite.new(:sender_id => current_user.id, :email => email, :vote => @vote)
        if @invite.save && @invite.recipient 
          link = vote_url(@vote)
          InvitationMailer.vote_invitation(@invite, link).deliver!
        else
          link = new_user_registration_url(:invite_token => @invite.token)
          InvitationMailer.new_invitation(@invite, link).deliver!
        end
      end
    end
    redirect_to root_path, notice: "Emails sent."
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

    def check_answered
      answered = current_user.answers.find_by(:vote_id => params[:id])
      redirect_to root_path, notice: "Already cast vote" if answered
    end

    def check_invited
      invited = current_user.invitations.find_by(:vote_id => params[:id])
      unless invited || current_user?(@vote.creator)
        redirect_to root_path, notice: "Sorry, you weren't invited"
      end
    end

    def check_creator
      unless current_user?(@vote.creator)
        redirect_to root_path, notice: "You do not have access to edit/delete."
      end
    end

    def current_user?(user)
      user == current_user
    end

    
end
