class QqMailer < ActionMailer::Base
  default from: ENV["QMAIL_USERNAME"]

  QqMailer.smtp_settings = {
    address: "smtp.qq.com",
    port: 25,
    domain: ENV["DOMAIN_NAME"],
    authentication: "plain",
    user_name: ENV["QMAIL_USERNAME"],
    password: ENV["QMAIL_PASSWORD"]
  }

  def marketing(mail_tmp, from_email, to_email)   
    @mail_tmp = mail_tmp
    puts "..... -> #{to_email}"
    mail to: to_email, subject: @mail_tmp.title
  end
end