class InvitesController < ApplicationController
  include InvitesHelper
  before_action :authenticate_user!
  before_action :set_vote
  before_action :authorize_creator

  EMAIL_REGEX = /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i
  MAX_EMAILS  = 30

  def new_many
  end

  def create_many
    emails = params[:invite_emails].scan(EMAIL_REGEX).take(MAX_EMAILS)
    emails.delete_if { |email| email == @vote.creator.email }
    count = 0
    emails.each do |email|
      @invite = @vote.invites.build(:email => email, :sender => current_user)
      if @invite.save
        send_invite(@invite)
        count += 1
      end
    end
    redirect_to vote_path(@vote), :notice => "#{InvitesHelper.pluralize(count, "email")} sent!"
  end

  private

  def set_vote
    @vote = Vote.find(params[:id])
  end

  def authorize_creator
    redirect_to root_path, notice: "You do not have access to invite." unless current_user == @vote.creator
  end

  # send a vote invite or new registraiton invite if they're not user already
  def send_invite(invite)
    if invite.recipient
      InvitationMailer.vote_invitation(invite, vote_url(@vote)).deliver
    else
      link = new_user_registration_url(:invite_token => invite.token)
      InvitationMailer.new_invitation(invite, link).deliver
    end
  end
end
