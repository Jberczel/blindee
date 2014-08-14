module VotesHelper
  def user_answered?
    current_user.answers.find_by(:vote_id => params[:id])
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


  def invited?(email)
    @vote.invites.find_by(email: email)
  end

end