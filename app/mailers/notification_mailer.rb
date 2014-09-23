class NotificationMailer < MandrillMailer::TemplateMailer
  default from: "no-reply@blindee.com", from_name: "Blindee"


  def send_notification(vote, url, comment)
    invitees = vote.invites.map { |i| i.email }

    mandrill_mail template: 'vote_notification',
      subject: "Blindee Vote Notification!",
      to: invitees,
      vars: {
        'USER' => vote.creator.email,
        'QUESTION' => vote.question,
        'COMMENT' => comment,
        'LINK' => url,
        'LIST_COMPANY' => 'Blindee'
      },
      important: true,
      inline_css: true,
      async: true
  end
end
