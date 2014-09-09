class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      @created_votes = current_user.created_votes
      @invitations = current_user.invitations
    end
  end

  def about
  end

  def contact
  end
end
