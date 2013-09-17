class Gmailer < ActionMailer::Base
  default from: ENV["QMAIL_USERNAME"]

  Gmailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    domain: ENV["DOMAIN_NAME"],
    authentication: "plain",
    enable_starttls_auto: true,
    user_name: ENV["GMAIL_USERNAME"],
    password: ENV["GMAIL_PASSWORD"]
  }

  def marketing(mail_tmp_id, from_email, to_email) 
    sleep(120 + rand(600)) 
    @mail_tmp = MailTmp.find(mail_tmp_id)
    mail to: to_email, subject: @mail_tmp.title
  end

end
