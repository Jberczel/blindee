class InvitationMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invitation_mailer.invitation.subject
  #
  def new_invitation(invite, url)
    @invite = invite
    @url = url

    mail to: "#{@invite.email}", subject: 'welcome!!!'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invitation_mailer.notification.subject
  #
  def vote_invitation(invite, url)
    @invite = invite
    @url = url

    mail to: "#{@invite.email}", subject: "You've got a question: #{@invite.vote.question}"
  end
end
