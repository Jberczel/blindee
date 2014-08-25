class InvitesController < ApplicationController
  include InvitesHelper
  before_action :set_vote
  before_action :check_creator

  def new_many
  end

  def create_many
    @vote = Vote.find(params[:id])
    emails = params[:invite_emails].split(/,|\r\n|\n/)
    invalid_emails = []

    emails.each do |email|
      email = email.strip

      unless invited?(email) 
        @invite = Invite.new(:sender_id => current_user.id, :email => email, :vote => @vote)
        if @invite.save && @invite.recipient 
          link = vote_url(@vote)
          InvitationMailer.vote_invitation(@invite, link).deliver!
        elsif @invite.save
          link = new_user_registration_url(:invite_token => @invite.token)
          InvitationMailer.new_invitation(@invite, link).deliver!
        else
          invalid_emails << email
        end
      end
    end

    if invalid_emails.any?
      flash[:notice] = "Not all emails sent: #{invalid_emails}"
    else
      flash[:success] = 'Emails sent!'
    end
    redirect_to root_path
  end

  private
    def invite_params
      params.require(:invite).permit(:email)
    end

    def set_vote
      @vote = Vote.find(params[:id])
    end

end


