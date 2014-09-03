module VotesHelper
  def user_answered?
    current_user.answers.find_by(:vote_id => params[:id])
  end

  def check_invited
    invited = current_user.invitations.find_by(:vote_id => params[:id])
    unless invited || current_user?(@vote.creator)
      redirect_to root_path, notice: "Sorry, you weren't invited to this Vote."
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

  def voted?(answers)
    answers.find_by(user: current_user)
  end

  def details?(vote)
    !vote.details.blank?
  end

  def wrap(content)
    sanitize(raw(content.split.map{ |s| wrap_long_string(s) }.join(' ')))
  end

  private

    def wrap_long_string(text, max_width = 30)
      zero_width_space = "&#8203;"
      regex = /.{1,#{max_width}}/
      (text.length < max_width) ? text :
                                  text.scan(regex).join(zero_width_space)
    end
end