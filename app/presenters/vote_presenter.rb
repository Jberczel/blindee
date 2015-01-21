class VotePresenter < BasePresenter
  MIN_PART_RATE = 0.75 # minimum participation rate before results can be seen
  MIN_DAYS      = 2    # after 2 days, voters can see results despite participation rate

  def render_participation_rate
    if public_vote?
      "#{h.pluralize(answers_count, 'vote')} so far"
    else
      "#{h.number_to_percentage(participation_rate * 100, precision: 0)} participation rate"
    end
  end

  def render_vote_count
    h.content_tag :div, :class => 'vote-count' do
      if public_vote?
       "#{h.pluralize(answers_count, 'vote')} so far"
      else
        "#{answers_count} of #{h.pluralize(invites_count + 1, 'vote')}" +
        " (required: #{((invites_count + 1) * MIN_PART_RATE).ceil})"
      end
    end
  end

  def comments
    answers.map { |a| a.comment }
  end

  def details
    @model.details.blank? ? "No details." : h.markdown(@model.details)
  end

  def current_user_invited?
    invites.find_by(recipient: h.current_user) || creator_is_current_user?
  end

  def current_user_voted?
    answers.find_by(user: h.current_user)
  end

  def creator_is_current_user?
    creator == h.current_user
  end

  def finished?
    return true if public_vote? # no requirement for public vote
    participation_rate >= MIN_PART_RATE || created_at <= MIN_DAYS.days.ago
  end

  def public_vote?
    @model.public_vote
  end

  def invitees
    invites.map(&:email).join(", ")
  end

  def creator_email
    creator.email
  end

  def answers_count
    answers.count
  end

  def invites_count
    invites.count
  end

  def notifications_sent?
    notified
  end

  private

  def participation_rate
    (answers_count.to_f / (invites_count + 1))
  end
end
