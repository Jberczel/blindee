class InvitationMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invitation_mailer.invitation.subject
  #
  def invitation(invite, url)
    @invite = invite
    @url = url

    mail to: "to@example.org", subject: 'welcome!!!'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invitation_mailer.notification.subject
  #
  def notification
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
