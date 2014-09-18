class InvitesController < ApplicationController
  include InvitesHelper
  before_action :authenticate_user!
  before_action :set_vote
  before_action :check_creator

  def new_many
  end

  def create_many
    emails = params[:invite_emails].scan(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i)
    # use a constant or class variable to limit inivtes per form. 
    #TODO: need to restrict by actually counting number of invites
    emails = emails[0..30]
    count = 0

    emails.each do |email|
      # for each e-mail, send invite unless already invited or creator's email
      unless invited?(email) || creator?(email)
        @invite = Invite.new(:sender_id => current_user.id, :email => email, :vote => @vote)
        if @invite.save
          send_invite(@invite)
          count += 1
        end
      end
    end
    flash[:notice] = "#{InvitesHelper.pluralize(count, "email")} sent!"
    redirect_to vote_path(@vote)
  end

  private
    def invite_params
      params.require(:invite).permit(:email)
    end

    def set_vote
      @vote = Vote.find(params[:id])
    end

    # send a vote invite or new registraiton invite if they're not user already
    def send_invite(invite)
      if invite.recipient
        link = vote_url(@vote)
        InvitationMailer.vote_invitation(invite, link).deliver
      else
        link = new_user_registration_url(:invite_token => invite.token)
        InvitationMailer.new_invitation(invite, link).deliver
      end
    end

end


