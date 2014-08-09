class InvitesController < ApplicationController

  def create
    @invite = Invite.new(invite_params) # Make a new Invite
    @invite.sender_id = current_user.id # set the sender to the current user
    if @invite.save

      if @invite.recipient
        InvitationMailer.vote_invitation(@invite, vote_url(@invite.vote)).deliver 
      else
        InvitationMailer.new_invitation(@invite, new_user_registration_url(:invite_token => @invite.token)).deliver
      end  
      
      redirect_to root_url, notice: "email sent!"  
    end
  end

  private
    def invite_params
      params.require(:invite).permit(:email, :vote_id)
    end

end


