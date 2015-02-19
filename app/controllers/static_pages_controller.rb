class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      created_votes     = current_user.created_votes.includes(:creator)
      invited_votes     = current_user.invitations.includes(:vote).map(&:vote)

      @votes_presenter   = VotePresenter.wrap(created_votes, view_context)
      @invites_presenter = VotePresenter.wrap(invited_votes, view_context)
    end
  end

  def about
  end

end
