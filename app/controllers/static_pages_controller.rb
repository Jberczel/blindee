class StaticPagesController < ApplicationController
  def home
    @created_votes = current_user.created_votes
    @invitations = current_user.invitations
  end

  def about
  end

  def contact
  end
end
