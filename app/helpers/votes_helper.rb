module VotesHelper

  def check_creator
    unless current_user?(@vote.creator)
      redirect_to root_path, notice: "You do not have access to edit/delete."
    end
  end

  def check_invited
    invited = current_user.invitations.find_by(:vote_id => params[:id])
    unless invited || current_user?(@vote.creator)
      redirect_to root_path, notice: "Sorry, you weren't invited to this Vote."
    end
  end

  # duplicated
  def current_user?(user)
    user == current_user
  end

  # duplicated
  def voted?(answers)
    answers.find_by(user: current_user)
  end

  def details?(vote)
    !vote.details.blank?
  end

  def public_vote?
    @vote.public?
  end

end