class InvitesController < ApplicationController
  include InvitesHelper
  before_action :authenticate_user!
  before_action :set_vote
  before_action :check_creator

  def new_many
  end

  def create_many

    emails = params[:invite_emails].scan(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i)
    emails = emails[0..30]

    emails.each do |email|
      # for each e-mail, send invite unless already invited or current user's email
      unless invited?(email) || creator?(email)
        @invite = Invite.new(:sender_id => current_user.id, :email => email, :vote => @vote)
        if @invite.save
          if @invite.recipient 
            link = vote_url(@vote)
            InvitationMailer.vote_invitation(@invite, link).deliver
          else
            link = new_user_registration_url(:invite_token => @invite.token)
            InvitationMailer.new_invitation(@invite, link).deliver
          end
        end
      end
    end

    flash[:notice] = 'Emails sent!'
    redirect_to vote_path(@vote)
  end

  private
    def invite_params
      params.require(:invite).permit(:email)
    end

    def set_vote
      @vote = Vote.find(params[:id])
    end

    # helper method for checking 
    def creator?(email)
      current_user.email == email
    end

end


