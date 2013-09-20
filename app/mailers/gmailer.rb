class Gmailer < ActionMailer::Base
  default from: ENV['GMAIL_USERNAME']

  Gmailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    authentication: "plain",
    enable_starttls_auto: true,
    user_name: ENV['GMAIL_USERNAME'],
    password: ENV['GMAIL_PASSWORD'],
    domain: ENV['DOMAIN']
  }

  def marketing(mail_tmp_id, to_email)
    puts '----------------------'
    puts Gmailer.smtp_settings
    @mail_tmp = MailTmp.find(mail_tmp_id)
    mail to: to_email, subject: @mail_tmp.title
  end
end
