class InvitesController < ApplicationController

  def create
    @invite = Invite.new(invite_params) # Make a new Invite
    @invite.sender_id = current_user.id # set the sender to the current user
    if @invite.save
      InvitationMailer.invitation(@invite, new_user_registration_path(:invite_token => @invite.token)).deliver #send the invite data to our mailer to deliver the email
    else
      # oh no, creating an new invitation failed
    end
  end

  private
    def invite_params
      params.require(:invite).permit(:email, :vote_id)
    end

end
