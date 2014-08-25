module InvitesHelper
  # helper function for unqiue emails for each vote
  def invited?(email)
    @vote.invites.find_by(email: email)
  end

  def current_user?(user)
    user == current_user
  end

 def check_creator
    unless current_user?(@vote.creator)
      redirect_to root_path, notice: "You do not have access to invite."
    end
  end

end