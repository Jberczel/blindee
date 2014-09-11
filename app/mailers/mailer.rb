class Mailer < MandrillMailer::TemplateMailer
  default from: "no-reply@blindee.com", from_name: "Blindee"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mailer.invitation.subject
  #
  def invitation
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  def new_user(user)
    mandrill_mail template: 'new_user',
      subject: "New User Registration",
      to: "jxberc@gmail.com",
      vars: {
        'USER' => user.email
      },
      important: true,
      inline_css: true,
      async: true
  end
end
