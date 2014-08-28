SMTP_SETTINGS = {
  address: 'smtp.mandrillapp.com',, # example: "smtp.sendgrid.net"
  authentication: :plain,
  domain: 'heroku.com', # example: "this-app.com"
  enable_starttls_auto: true,
  password: ENV.fetch('MANDRILL_APIKEY'),
  port: "587",
  user_name: ENV.fetch['MANDRILL_USERNAME']
}