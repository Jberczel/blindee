class InvitationMailer < MandrillMailer::TemplateMailer
  default from: "no-reply@blindee.com", from_name: "Blindee"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invitation_mailer.invitation.subject
  #
  def new_invitation(invite, url)
    mandrill_mail template: 'new_invitation',
      subject: "You're invited to a Blindee Vote",
      to: invite.email,
      vars: {
        'USER' => invite.sender.email,
        'QUESTION' => invite.vote.question,
        'LINK' => url,
        'LIST_COMPANY' => 'Blindee'
      },
      important: true,
      inline_css: true,
      async: true
  end

  def vote_invitation(invite, url)
    mandrill_mail template: 'vote_invitation',
      subject: "You're invited to a Blindee Vote",
      to: invite.email,
      vars: {
        'USER' => invite.sender.email,
        'QUESTION' => invite.vote.question,
        'LINK' => url,
        'LIST_COMPANY' => 'Blindee'
      },
      important: true,
      inline_css: true,
      async: true
  end
end
