class InvitesController < ApplicationController
  include InvitesHelper
  before_action :set_vote
  before_action :check_creator

  def new_many
  end

  def create_many

    emails = params[:invite_emails].split(/,|\r\n|\n/)[0..30] # only 30 invites

    emails.each do |email|
      email = email.strip

      unless invited?(email) 
        @invite = Invite.new(:sender_id => current_user.id, :email => email, :vote => @vote)
        if @invite.save && @invite.recipient 
          link = vote_url(@vote)
          InvitationMailer.vote_invitation(@invite, link).deliver
        elsif @invite.save
          link = new_user_registration_url(:invite_token => @invite.token)
          InvitationMailer.new_invitation(@invite, link).deliver
        end
      end
    end

    flash[:success] = 'Emails sent!'
    redirect_to vote_path(@vote)
  end

  private
    def invite_params
      params.require(:invite).permit(:email)
    end

    def set_vote
      @vote = Vote.find(params[:id])
    end

end


