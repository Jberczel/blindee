module InvitesHelper


  # helper function for unqiue emails for each vote
  def invited?(email)
    @vote.invites.find_by(email: email)
  end

end